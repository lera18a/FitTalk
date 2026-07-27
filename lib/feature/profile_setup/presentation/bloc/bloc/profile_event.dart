part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.firstNameChanged(String firstName) =
      _FirstNameChanged;
  const factory ProfileEvent.usernameChanged(String username) =
      _UsernameChanged;
  const factory ProfileEvent.avatarChanged(Uint8List? avatarBytes) =
      _AvatarChanged;
  const factory ProfileEvent.saveProfileSubmitted() = _SaveProfileSubmitted;
}
