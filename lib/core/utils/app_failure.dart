sealed class AppFailure {
  final Object? cause;
  final String? message;

  const AppFailure({this.message}) : cause = null;
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
  const EnterEmailFailure();
}

final class InvalidEmailFormatFailure extends AppFailure {
  const InvalidEmailFormatFailure();
}

final class InvalidAccountFailure extends AppFailure {
  const InvalidAccountFailure();
}

/// Storage failures
sealed class StorageFailure extends AppFailure {
  const StorageFailure();
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
