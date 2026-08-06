import 'package:bloc/bloc.dart';
import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_info_event.dart';
part 'profile_info_state.dart';
part 'profile_info_bloc.freezed.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  final ProfileRepository _repository;
  ProfileInfoBloc({required ProfileRepository repository})
    : _repository = repository,
      super(ProfileInfoState.initial()) {
    on<_LoadProfile>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(
    _LoadProfile event,
    Emitter<ProfileInfoState> emit,
  ) async {
    emit(const ProfileInfoState.loading());

    final result = await _repository.getProfile(event.userId);

    result.fold(
      (failure) {
        emit(ProfileInfoState.failure(failure.message));
      },
      (profile) {
        if (profile == null) {
          emit(const ProfileInfoState.failure('Пользователь не найден'));
          return;
        }

        emit(ProfileInfoState.loaded(profile));
      },
    );
  }
}
