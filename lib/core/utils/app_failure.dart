sealed class AppFailure {
  final Object? cause;
  final String? message;

  const AppFailure({this.message}) : cause = null;
}

class DefaultAppFailure extends AppFailure {
  final Object? cause;
  final String? message;

  const DefaultAppFailure({this.message, this.cause});
}

/// Email / OTP failures
final class EmailNotFoundFailure extends AppFailure {
  const EmailNotFoundFailure();
}

final class InvalidOtpFailure extends AppFailure {
  const InvalidOtpFailure();
}

final class OtpExpiredFailure extends AppFailure {
  const OtpExpiredFailure();
}

/// Input / form failures
final class EnterEmailFailure extends AppFailure {
  const EnterEmailFailure() : super(message: 'Please enter your email');
}

final class InvalidEmailFormatFailure extends AppFailure {
  const InvalidEmailFormatFailure() : super(message: 'Invalid email format');
}

final class InvalidAccountFailure extends AppFailure {
  const InvalidAccountFailure() : super(message: 'Invalid account');
}

/// Storage failures
sealed class StorageFailure extends AppFailure {
  const StorageFailure() : super(message: 'Unknown storage failure');
}

final class DbFailure extends StorageFailure {
  const DbFailure();
}

/// Network failures
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

/// Unknown failure
final class UnknownFailure extends AppFailure {
  const UnknownFailure() : super();
  @override
  Object? get cause => super.cause;
}
