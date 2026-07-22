import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fpdart/fpdart.dart';

class PasswordValidatorUseCase {
  const PasswordValidatorUseCase({
    this.minLength = 6,
    this.requireUppercase = false,
    this.requireDigit = false,
    this.requireSpecialChar = false,
  });

  final int minLength;
  final bool requireUppercase;
  final bool requireDigit;
  final bool requireSpecialChar;

  Either<AppFailure, void> call(String? value) {
    if (value == null || value.isEmpty) {
      return left(const EnterPasswordFailure());
    }

    if (value.length < minLength) {
      return left(PasswordTooShortFailure(minLength: minLength));
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return left(const PasswordNoUppercaseFailure());
    }

    if (requireDigit && !value.contains(RegExp(r'[0-9]'))) {
      return left(const PasswordNoDigitFailure());
    }

    if (requireSpecialChar &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return left(const PasswordNoSpecialCharFailure());
    }

    return right(null);
  }
}
