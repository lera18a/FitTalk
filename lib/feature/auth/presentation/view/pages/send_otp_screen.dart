import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/core/widgets/f_t_agreement_text.dart';
import 'package:fit_talk/core/widgets/f_t_text_field.dart';
import 'package:fit_talk/feature/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendOtpScreen extends StatelessWidget {
  const SendOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                log('📌 SendOtpScreen | state: $state', name: 'SendOtpScreen');

                final errorText = switch (state) {
                  AuthInitial(:final errorMessage) => errorMessage,
                  AuthFailure(:final message) => message,
                  _ => null,
                };

                if (errorText != null) {
                  log(
                    '❌ SendOtpScreen | errorText: $errorText',
                    name: 'SendOtpScreen',
                  );
                }

                return Padding(
                  padding: EdgeInsetsGeometry.all(32),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              'enterYourEmailAdress',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            FTTextField(
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'enterYourEmail',
                              prefixIcon: const Icon(CupertinoIcons.mail_solid),
                              errorText: errorText,
                              onChanged: (email) {
                                log(
                                  '✏️ SendOtpScreen | EmailTextChanged: $email',
                                  name: 'SendOtpScreen',
                                );
                                context.read<AuthBloc>().add(
                                  EmailTextChanged(email),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              label: const Text('log in'),
                              onPressed: () {
                                log(
                                  '🚀 SendOtpScreen | RequestOtp pressed',
                                  name: 'SendOtpScreen',
                                );
                                context.read<AuthBloc>().add(RequestOtp());
                              },
                            ),
                            FTAgreementText(text: 'userAgreementSignInEmail'),
                            const SizedBox(height: 30),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
