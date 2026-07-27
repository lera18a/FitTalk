part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {
  final EmailParams params;
  final String? errorMessage;

  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  AuthInitial({
    required this.params,
    this.errorMessage,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  AuthInitial copyWith({
    EmailParams? params,
    String? errorMessage,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
  }) {
    return AuthInitial(
      params: params ?? this.params,
      errorMessage: errorMessage,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    );
  }
}

final class AuthSignInSuccess extends AuthState {}

final class AuthSignUpSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String? message;

  AuthFailure({required this.message});
}

final class AuthLoggedOut extends AuthState {}
