import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FriendsRepository {
  Future<Either<AppFailure, List<ProfileModel>>> searchUsers(String query);

  Future<Either<AppFailure, ProfileModel>> getProfile(String userId);
}
