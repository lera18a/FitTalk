part of 'settings_profile_bloc.dart';

@freezed
class SettingsProfileState with _$SettingsProfileState {
  const factory SettingsProfileState.initial() = _Initial;

  const factory SettingsProfileState.loading() = _Loading;

  const factory SettingsProfileState.loaded({required ProfileModel profile}) =
      _Loaded;

  const factory SettingsProfileState.failure({required String message}) =
      _Failure;
}
