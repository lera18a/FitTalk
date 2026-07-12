import 'package:bloc/bloc.dart';
import 'package:fit_talk/feature/auth/domain/use_cases/request_otp.dart';
import 'package:fit_talk/feature/auth/domain/use_cases/verify_otp.dart';
import 'package:fit_talk/feature/auth/presentation/view/model/email_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RequestOtpUseCase _requestOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  AuthBloc({
    required RequestOtpUseCase requestOtpUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
  }) : _requestOtpUseCase = requestOtpUseCase,
       _verifyOtpUseCase = verifyOtpUseCase,
       super(AuthInitial(params: EmailParams(email: ''))) {
    on<EmailTextChanged>(_onEmailTextChanged);
    on<OtpTextfieldController>(_onOtpTextfieldController);
    on<SignInWithEmail>(_onSignInWithEmail);
    on<RequestOtp>(_onRequestOtp);
    on<LogOut>(_onLogOut);
  }

  /// GOOD
  void _onEmailTextChanged(EmailTextChanged event, Emitter<AuthState> emit) {
    if (state is AuthInitial) {
      final currentState = state as AuthInitial;
      final updatedParams = currentState.params.copyWith(
        email: event.email.trim(),
      );

      emit(currentState.copyWith(params: updatedParams));
    }
  }

  void _onOtpTextfieldController(
    OtpTextfieldController event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthInitial) {
      final currentState = state as AuthInitial;
      final updatedParams = currentState.params.copyWith(otp: event.otp);
      emit(currentState.copyWith(params: updatedParams));
    }
  }

  Future<void> _onRequestOtp(RequestOtp event, Emitter<AuthState> emit) async {
    debugPrint('📌 RequestOtp | state: $state');
    if (state is AuthInitial && state is SendOtp) {
      final currentState = state as AuthInitial;
      final params = currentState.params;
      final result = await _requestOtpUseCase(params);

      result.fold(
        (e) => emit(currentState.copyWith(errorMessage: e.message)),
        (token) => emit(SendOtp()),
      );
    }
  }

  Future<void> _onSignInWithEmail(
    SignInWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    if (state is AuthInitial) {
      final currentState = state as AuthInitial;
      final params = currentState.params;
      final result = await _verifyOtpUseCase(params);
      result.fold(
        (e) => emit(currentState.copyWith(errorMessage: e.message)),
        (_) => emit(AuthSuccess()),
      );
    }
  }

  Future<void> _onLogOut(LogOut event, Emitter<AuthState> emit) async {
    emit(
      AuthInitial(
        params: EmailParams(email: '', otp: ''),
      ),
    );
  }
}
