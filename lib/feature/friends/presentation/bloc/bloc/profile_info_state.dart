part of 'profile_info_bloc.dart';

@freezed
class ProfileInfoState with _$ProfileInfoState {
  const factory ProfileInfoState.initial() = _Initial;

  const factory ProfileInfoState.loading() = _Loading;

  const factory ProfileInfoState.loaded(ProfileModel profile) = _Loaded;

  const factory ProfileInfoState.failure(String message) = _Failure;
}
