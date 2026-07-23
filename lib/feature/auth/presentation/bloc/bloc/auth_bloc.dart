import 'package:bloc/bloc.dart';
import 'package:fit_talk/core/utils/app_failure.dart';
import 'package:fit_talk/feature/auth/domain/repository/auth_repository.dart';
import 'package:fit_talk/feature/auth/domain/use_cases/email_validator.dart';
import 'package:fit_talk/feature/auth/domain/use_cases/password_validator.dart';
import 'package:fit_talk/feature/auth/presentation/view/model/email_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final EmailValidatorUseCase _emailValidator;
  final PasswordValidatorUseCase _passwordValidator;
  // final RequestOtpUseCase _requestOtpUseCase;
  // final VerifyOtpUseCase _verifyOtpUseCase;
  AuthBloc({
    // required RequestOtpUseCase requestOtpUseCase,
    // required VerifyOtpUseCase verifyOtpUseCase,
    required EmailValidatorUseCase emailValidator,
    required PasswordValidatorUseCase passwordValidator,
    required AuthRepository authRepository,
  }) : _authRepository = authRepository,
       _emailValidator = emailValidator,
       _passwordValidator = passwordValidator,
       //  _requestOtpUseCase = requestOtpUseCase,
       //  _verifyOtpUseCase = verifyOtpUseCase,
       super(AuthInitial(params: EmailParams(email: ''))) {
    on<EmailTextChanged>(_onEmailTextChanged);
    on<PasswordTextChanged>(_onPasswordTextChanged);
    on<ConfirmPassword>(_onConfirmPassword);
    on<SignInWithEmail>(_onSignInWithEmail);
    on<SignUpWithEmail>(_onSignUpWithEmail);
    on<LogOut>(_onLogOut);
  }

  void _onEmailTextChanged(EmailTextChanged event, Emitter<AuthState> emit) {
    if (state is! AuthInitial) return;
    final current = state as AuthInitial;
    emit(
      current.copyWith(
        params: current.params.copyWith(email: event.email.trim()),
      ),
    );
  }

  void _onPasswordTextChanged(
    PasswordTextChanged event,
    Emitter<AuthState> emit,
  ) {
    if (state is! AuthInitial) return;
    final current = state as AuthInitial;
    emit(
      current.copyWith(
        params: current.params.copyWith(password: event.password),
      ),
    );
  }

  void _onConfirmPassword(ConfirmPassword event, Emitter<AuthState> emit) {
    if (state is! AuthInitial) return;
    final current = state as AuthInitial;
    emit(
      current.copyWith(
        params: current.params.copyWith(confirmPassword: event.password),
      ),
    );
  }

  Future<void> _onSignInWithEmail(
    SignInWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    if (state is! AuthInitial) return;
    final current = state as AuthInitial;
    final params = current.params;

    final emailError = _emailValidator(
      params.email,
    ).fold((f) => f.message, (_) => null);
    final passwordError = _passwordValidator(
      params.password,
    ).fold((f) => f.message, (_) => null);

    if (emailError != null || passwordError != null) {
      emit(
        current.copyWith(emailError: emailError, passwordError: passwordError),
      );
      return;
    }

    final result = await _authRepository.signinWithPassword(
      email: params.email,
      password: params.password ?? '',
    );

    result.fold(
      (failure) => emit(current.copyWith(errorMessage: failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> _onSignUpWithEmail(
    SignUpWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    if (state is! AuthInitial) return;
    final current = state as AuthInitial;
    final params = current.params;

    // 1. СНАЧАЛА валидация
    final emailError = _emailValidator(
      params.email,
    ).fold((f) => f.message, (_) => null);
    final passwordError = _passwordValidator(
      params.password,
    ).fold((f) => f.message, (_) => null);
    final confirmError = _validateConfirmPassword(
      password: params.password,
      confirmPassword: params.confirmPassword,
    );

    if (emailError != null || passwordError != null || confirmError != null) {
      emit(
        current.copyWith(
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmError,
        ),
      );
      return;
    }

    final result = await _authRepository.signUp(
      email: params.email,
      password: params.password ?? '',
    );

    result.fold(
      (failure) => emit(current.copyWith(errorMessage: failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  String? _validateConfirmPassword({
    required String? password,
    required String? confirmPassword,
  }) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _onLogOut(LogOut event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.signOut();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure(message: 'Не удалось выйти из аккаунта'));
    }
  }
}
