import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<AppFailure, void>> requestOtp({required String email});

  Future<Either<AppFailure, void>> verifyOtp({
    required String email,
    required String? token,
  });
  Future<void> signOut();
}
