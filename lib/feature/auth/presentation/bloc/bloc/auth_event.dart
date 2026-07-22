part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class EmailTextChanged extends AuthEvent {
  final String email;

  EmailTextChanged(this.email);
}

final class PasswordTextChanged extends AuthEvent {
  final String password;

  PasswordTextChanged(this.password);
}

final class ConfirmPassword extends AuthEvent {
  final String password;

  ConfirmPassword(this.password);
}

final class SignUpWithEmail extends AuthEvent {
  SignUpWithEmail();
}

final class SignInWithEmail extends AuthEvent {
  SignInWithEmail();
}

final class LogOut extends AuthEvent {
  LogOut();
}
