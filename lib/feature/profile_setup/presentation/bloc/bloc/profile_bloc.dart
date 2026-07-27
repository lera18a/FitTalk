import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/core/utils/image_compressor.dart';
import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  // Безопасно получаем ID текущего авторизованного пользователя из Supabase
  String get _currentUserId =>
      Supabase.instance.client.auth.currentUser?.id ?? '';
  ProfileBloc({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository,
      super(const ProfileState()) {
    on<_FirstNameChanged>(_onFirstNameChanged);
    on<_UsernameChanged>(_onUsernameChanged);
    on<_AvatarChanged>(_onAvatarChanged);
    on<_SaveProfileSubmitted>(_onSaveProfile);

    debugPrint('🚀 ProfileBloc создан');
  }

  Future<void> _onFirstNameChanged(
    _FirstNameChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        firstName: event.firstName,
        status: ProfileSetupStatus.initial,
      ),
    );
  }

  Future<void> _onUsernameChanged(
    _UsernameChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        username: event.username,
        status: ProfileSetupStatus.initial,
      ),
    );
  }

  Future<void> _onAvatarChanged(
    _AvatarChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        avatarBytes: event.avatarBytes,
        status: ProfileSetupStatus.initial,
      ),
    );
  }

  Future<void> _onSaveProfile(
    _SaveProfileSubmitted event,
    Emitter<ProfileState> emit,
  ) async {
    if (!state.isFormValid) {
      final error = !state.isAvatarValid
          ? 'Добавьте фотографию профиля'
          : 'Проверьте заполнение полей';
      emit(
        state.copyWith(status: ProfileSetupStatus.failure, errorMessage: error),
      );
      return;
    }

    if (_currentUserId.isEmpty) {
      emit(
        state.copyWith(
          status: ProfileSetupStatus.failure,
          errorMessage: 'Пользователь не авторизован',
        ),
      );
      return;
    }

    emit(state.copyWith(status: ProfileSetupStatus.loading));
    File? tempFile;

    try {
      // 1. Создаем временный файл
      final tempDir = await getTemporaryDirectory();
      tempFile = File('${tempDir.path}/avatar_$_currentUserId.jpg');

      // 2. Сжимаем изображение
      await ImageCompressor.compressBytesToFile(
        bytes: state.avatarBytes!,
        targetFile: tempFile,
        quality: 70,
      );

      // 3. Загружаем аватар
      final avatarResult = await _profileRepository.uploadAvatar(
        tempFile,
        _currentUserId,
      );

      switch (avatarResult) {
        case Left(value: final failure):
          emit(
            state.copyWith(
              status: ProfileSetupStatus.failure,
              errorMessage: failure.message,
            ),
          );
          return;

        case Right(value: final avatarUrl):
          // 4. Создаем модель профиля
          final profile = ProfileModel(
            id: _currentUserId,
            firstName: state.firstName,
            username: state.username,
            avatarUrl: avatarUrl,
          );

          // 5. Сохраняем профиль в БД
          final saveResult = await _profileRepository.saveProfile(profile);

          switch (saveResult) {
            case Left(value: final failure):
              emit(
                state.copyWith(
                  status: ProfileSetupStatus.failure,
                  errorMessage: failure.message,
                ),
              );
              return; // Явное прерывание выполнения
            case Right():
              emit(state.copyWith(status: ProfileSetupStatus.success));
          }
      }
    } catch (e, stackTrace) {
      debugPrint('📜 Стек вызовов: $stackTrace');
      emit(
        state.copyWith(
          status: ProfileSetupStatus.failure,
          errorMessage: 'Непредвиденная ошибка: $e',
        ),
      );
    } finally {
      // Обязательная очистка кэша устройства
      if (tempFile != null && await tempFile.exists()) {
        try {
          await tempFile.delete();
          debugPrint('🗑️ Временный файл аватара успешно удален');
        } catch (e) {
          debugPrint('⚠️ Не удалось удалить временный файл: $e');
        }
      }
    }
  }
}
