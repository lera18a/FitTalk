part of 'profile_info_bloc.dart';

@freezed
abstract class ProfileInfoEvent with _$ProfileInfoEvent {
  const factory ProfileInfoEvent.loadProfile(String userId) = _LoadProfile;
}
