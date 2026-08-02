import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/friends/data/datasource/friends_datasource.dart';
import 'package:fit_talk/feature/friends/domain/repository/friends_repository.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FriendsRepositoryImpl implements FriendsRepository {
  FriendsRepositoryImpl(this._datasource, this._client);

  final FriendsDatasource _datasource;
  final SupabaseClient _client;

  @override
  Future<Either<AppFailure, List<ProfileModel>>> searchUsers(
    String query,
  ) async {
    try {
      final currentUserId = _client.auth.currentUser!.id;

      final data = await _datasource.searchUsers(
        query: query,
        currentUserId: currentUserId,
      );

      return right(data.map(ProfileModel.fromJson).toList());
    } catch (e, s) {
      return left(DefaultAppFailure(cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<AppFailure, ProfileModel>> getProfile(String userId) async {
    try {
      final data = await _datasource.getProfile(userId);

      return right(ProfileModel.fromJson(data));
    } catch (e, s) {
      return left(DefaultAppFailure(cause: e, stackTrace: s));
    }
  }
}
