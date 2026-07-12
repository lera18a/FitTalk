part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class EmailTextChanged extends AuthEvent {
  final String email;

  EmailTextChanged(this.email);
}

final class OtpTextfieldController extends AuthEvent {
  final String otp;

  OtpTextfieldController(this.otp);
}

final class SignInWithEmail extends AuthEvent {
  SignInWithEmail();
}

final class RequestOtp extends AuthEvent {
  RequestOtp();
}

final class LogOut extends AuthEvent {
  LogOut();
}
