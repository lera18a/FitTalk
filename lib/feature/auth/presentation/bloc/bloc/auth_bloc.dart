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

  void _onEmailTextChanged(EmailTextChanged event, Emitter<AuthState> emit) {
    if (state is AuthInitial) {
      final currentState = state as AuthInitial;
      final updatedParams = currentState.params.copyWith(
        email: event.email.trim(),
      );
      emit(currentState.copyWith(params: updatedParams, errorMessage: null));
    }
  }

  void _onOtpTextfieldController(
    OtpTextfieldController event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthOtpSend) {
      final currentState = state as AuthOtpSend;
      emit(
        currentState.copyWith(
          params: currentState.params.copyWith(otp: event.otp),
        ),
      );
    }
  }

  Future<void> _onRequestOtp(RequestOtp event, Emitter<AuthState> emit) async {
    debugPrint('📌 RequestOtp | state: $state');
    final EmailParams? params = switch (state) {
      AuthInitial(:final params) => params,
      AuthOtpSend(:final params) => params,
      _ => null,
    };

    if (params == null) return;

    final result = await _requestOtpUseCase(params);
    result.fold((failure) {
      final initialState = state as AuthInitial;
      final otpSendState = state as AuthInitial;
      if (state is AuthInitial) {
        emit(initialState.copyWith(errorMessage: failure.message));
      } else if (state is AuthOtpSend) {
        emit(otpSendState.copyWith(errorMessage: failure.message));
      }
    }, (_) => emit(AuthOtpSend(params: params)));
    // }, (_) => emit(AuthSuccess()));
  }

  Future<void> _onSignInWithEmail(
    SignInWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    if (state is! AuthOtpSend) return;
    final currentState = state as AuthOtpSend;
    final params = currentState.params;
    final result = await _verifyOtpUseCase(params);
    result.fold(
      (e) => emit(currentState.copyWith(errorMessage: e.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> _onLogOut(LogOut event, Emitter<AuthState> emit) async =>
      emit(AuthInitial(params: EmailParams(email: '')));
}
