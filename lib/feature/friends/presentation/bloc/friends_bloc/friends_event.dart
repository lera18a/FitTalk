part of 'friends_bloc.dart';

@freezed
abstract class FriendsEvent with _$FriendsEvent {
  const factory FriendsEvent.searchChanged(String query) = _SearchChanged;
}
