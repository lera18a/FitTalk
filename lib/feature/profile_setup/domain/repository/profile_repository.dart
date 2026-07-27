import 'dart:io' show File;

import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/model/profile.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<AppFailure, ProfileModel?>> getProfile(String id);
  Future<Either<AppFailure, void>> saveProfile(ProfileModel profile);
  Future<Either<AppFailure, String>> uploadAvatar(File file, String userId);
}
