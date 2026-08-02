part of 'friends_bloc.dart';

@freezed
abstract class FriendsState with _$FriendsState {
  const factory FriendsState.initial(
    String query,
    List<ProfileModel> users,
    bool isLoading,
    String? error,
  ) = _Initial;
}
