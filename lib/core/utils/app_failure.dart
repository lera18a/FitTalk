sealed class AppFailure {
  final Object? cause;
  final StackTrace? stackTrace;
  const AppFailure({this.cause, this.stackTrace});
}

class DefaultAppFailure extends AppFailure {
  const DefaultAppFailure({super.cause, super.stackTrace});
}

/// Email / OTP failures
final class EmailNotFoundFailure extends AppFailure {
  const EmailNotFoundFailure();
}

final class InvalidPasswordFailure extends AppFailure {
  const InvalidPasswordFailure();
}

final class InvalidOtpFailure extends AppFailure {
  const InvalidOtpFailure();
}

final class OtpExpiredFailure extends AppFailure {
  const OtpExpiredFailure();
}

// ---------- Input / form ----------
final class EnterEmailFailure extends AppFailure {
  const EnterEmailFailure() : super();
}

final class InvalidEmailFormatFailure extends AppFailure {
  const InvalidEmailFormatFailure() : super();
}

final class InvalidAccountFailure extends AppFailure {
  const InvalidAccountFailure() : super();
}

// ---------- Storage ----------

sealed class StorageFailure extends AppFailure {
  const StorageFailure() : super();
}

final class DbFailure extends StorageFailure {
  const DbFailure();
}

// ---------- Network ----------

sealed class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

final class NoInternetFailure extends NetworkFailure {
  const NoInternetFailure();
}

final class UnauthorizedFailure extends NetworkFailure {
  const UnauthorizedFailure();
}

final class ServerFailure extends NetworkFailure {
  final int code;
  const ServerFailure({required this.code});
}

// ---------- Password failures ----------
final class EnterPasswordFailure extends AppFailure {
  const EnterPasswordFailure();
}

final class PasswordTooShortFailure extends AppFailure {
  final int minLength;
  const PasswordTooShortFailure({required this.minLength});
}

final class PasswordNoUppercaseFailure extends AppFailure {
  const PasswordNoUppercaseFailure();
}

final class PasswordNoDigitFailure extends AppFailure {
  const PasswordNoDigitFailure();
}

final class PasswordNoSpecialCharFailure extends AppFailure {
  const PasswordNoSpecialCharFailure();
}

// / Unknown failure
final class UnknownFailure extends AppFailure {
  const UnknownFailure() : super();
  @override
  Object? get cause => super.cause;
}

extension AppFailureX on AppFailure {
  String get message => switch (this) {
    EnterPasswordFailure() => 'Please enter your password',
    PasswordTooShortFailure(minLength: final len) =>
      'Password must be at least $len characters',
    PasswordNoUppercaseFailure() =>
      'Password must contain at least one uppercase letter',
    PasswordNoDigitFailure() => 'Password must contain at least one digit',
    PasswordNoSpecialCharFailure() =>
      'Password must contain at least one special character',
    InvalidPasswordFailure() => 'Invalid password',
    EnterEmailFailure() => 'Please enter your email',
    InvalidEmailFormatFailure() => 'Invalid email format',
    InvalidAccountFailure() => 'Invalid account',
    EmailNotFoundFailure() => 'Email not found',
    InvalidPasswordFailure() => 'Invalid password',
    InvalidOtpFailure() => 'Invalid OTP code',
    OtpExpiredFailure() => 'OTP code has expired',
    NoInternetFailure() => 'No internet connection',
    UnauthorizedFailure() => 'You are not authorized',
    ServerFailure(code: final code) => 'Server error ($code)',
    DbFailure() => 'Database error',
    UnknownFailure() => 'Unknown error',
    DefaultAppFailure(cause: final cause) =>
      cause?.toString() ?? 'Something went wrong',
    // ignore: unreachable_switch_case
    _ => 'Something went wrong',
  };
}
