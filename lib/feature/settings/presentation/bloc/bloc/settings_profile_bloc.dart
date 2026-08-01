import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'settings_profile_event.dart';
part 'settings_profile_state.dart';
part 'settings_profile_bloc.freezed.dart';

class SettingsProfileBloc
    extends Bloc<SettingsProfileEvent, SettingsProfileState> {
  final ProfileRepository _profileRepository;
  final SupabaseClient _client;

  String? get _currentUserId => _client.auth.currentUser?.id;
  SettingsProfileBloc({
    required ProfileRepository profileRepository,
    required SupabaseClient client,
  }) : _profileRepository = profileRepository,
       _client = client,
       super(_Initial()) {
    on<_LoadCurrentProfile>(_onLoadCurrentProfile);
    on<_UpdateAvatar>(_onUpdateAvatar);

    add(const SettingsProfileEvent.loadCurrentProfile());
  }

  Future<void> _onLoadCurrentProfile(
    _LoadCurrentProfile event,
    Emitter<SettingsProfileState> emit,
  ) async {
    final userId = _currentUserId;

    if (userId == null || userId.isEmpty) {
      emit(
        const SettingsProfileState.failure(
          message: 'Пользователь не авторизован',
        ),
      );
      return;
    }

    emit(const SettingsProfileState.loading());

    final result = await _profileRepository.getProfile(userId);

    result.fold(
      (failure) {
        emit(SettingsProfileState.failure(message: failure.message));
      },
      (profile) {
        if (profile == null) {
          emit(
            const SettingsProfileState.failure(message: 'Профиль не найден'),
          );
          return;
        }

        emit(SettingsProfileState.loaded(profile: profile));
      },
    );
  }

  Future<void> _onUpdateAvatar(
    _UpdateAvatar event,
    Emitter<SettingsProfileState> emit,
  ) async {
    final userId = _currentUserId;
    if (userId == null) return;

    // Запоминаем старый профиль, чтобы не потерять данные при ошибке
    final currentState = state;
    ProfileModel? oldProfile;
    if (currentState is _Loaded) {
      oldProfile = currentState.profile;
    }

    emit(const SettingsProfileState.loading());

    final uploadResult = await _profileRepository.uploadAvatar(
      event.file,
      userId,
    );

    await uploadResult.fold(
      (failure) async =>
          emit(SettingsProfileState.failure(message: failure.message)),
      (newUrl) async {
        // Создаем обновленную модель
        final updatedProfile =
            oldProfile?.copyWith(avatarUrl: newUrl) ??
            ProfileModel(id: userId, avatarUrl: newUrl);

        final saveResult = await _profileRepository.saveProfile(updatedProfile);

        saveResult.fold(
          (failure) =>
              emit(SettingsProfileState.failure(message: failure.message)),
          (_) => emit(SettingsProfileState.loaded(profile: updatedProfile)),
        );
      },
    );
  }
}
