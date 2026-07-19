import 'package:fit_talk/feature/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fit_talk/feature/auth/presentation/view/widgets/code_input.dart';
import 'package:fit_talk/feature/auth/presentation/view/widgets/frozen_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  // final String token;
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _isTimerFinished = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('enterYourCode')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final errorText = switch (state) {
              AuthOtpSend(:final errorMessage) => errorMessage,
              AuthFailure(:final message) => message,
              _ => null,
            };

            final params = switch (state) {
              AuthInitial(:final params) => params,
              _ => null,
            };
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              children: [
                Text(
                  'context.l10n.enterYourCode',
                  // style: context.td.textTheme.displayLarge,
                ),
                Text(
                  '    context.l10n.theCodeVerification',
                  // style: context.td.textTheme.bodyMedium,
                ),
                // Text(emailParams.email.toString()),
                Column(
                  children: [
                    CodeInput(
                      errorText: errorText,
                      onChanged: (otp) => context.read<AuthBloc>().add(
                        OtpTextfieldController(otp),
                      ),
                      onSubmitted: () {
                        context.read<AuthBloc>().add(SignInWithEmail());
                      },
                    ),
                    if (!_isTimerFinished)
                      FrozenTimer(
                        onFinished: () => setState(() {
                          _isTimerFinished = true;
                        }),
                      )
                    else
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(RequestOtp());
                          setState(() {
                            _isTimerFinished = false;
                          });
                        },
                        child: Text('sendTheCodeAgain'),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
