part of 'settings_profile_bloc.dart';

@freezed
class SettingsProfileEvent with _$SettingsProfileEvent {
  const factory SettingsProfileEvent.loadCurrentProfile() = _LoadCurrentProfile;

  const factory SettingsProfileEvent.updateAvatar(File file) = _UpdateAvatar;
}
