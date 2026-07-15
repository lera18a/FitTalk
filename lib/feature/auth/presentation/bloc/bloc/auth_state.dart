part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {
  final EmailParams params;
  final String? errorMessage;

  AuthInitial({required this.params, this.errorMessage});

  AuthInitial copyWith({EmailParams? params, String? errorMessage}) {
    return AuthInitial(
      params: params ?? this.params,
      errorMessage: errorMessage,
    );
  }
}

final class AuthSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String? message;

  AuthFailure({required this.message});
}
