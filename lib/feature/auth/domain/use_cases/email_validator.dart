import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fpdart/fpdart.dart';

class EmailValidatorUseCase {
  Either<AppFailure, void> call(String? email) {
    if (email == null) return Left(UnknownFailure());

    if (email.isEmpty) {
      return Left(EnterEmailFailure());
    }

    final emailRegExp = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegExp.hasMatch(email.trim())) {
      return Left(InvalidEmailFormatFailure());
    }

    return Right(null);
  }
}
