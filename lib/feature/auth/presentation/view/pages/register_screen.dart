import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/core/widgets/f_t_text_form_field.dart';
import 'package:fit_talk/feature/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final authState = state is AuthInitial ? state : null;

              final emailError = authState?.emailError;
              final passwordError = authState?.passwordError;
              final confirmPasswordError = authState?.confirmPasswordError;
              final errorText = switch (state) {
                AuthInitial(:final errorMessage) => errorMessage,
                AuthFailure(:final message) => message,
                _ => null,
              };
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Картинка
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/fitTalk.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .04),

                  // Заголовок
                  Text(
                    'Create account',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * .01),
                  Text(
                    'Sign up to get started with FitTalk',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: size.height * .03),
                  // Full name
                  // Text(
                  //   'Full name',
                  //   style: theme.textTheme.bodySmall?.copyWith(
                  //     color: theme.colorScheme.onSurfaceVariant,
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  // FTTextFormField(
                  //   onChanged: (String value) {},
                  //   hintText: 'Enter your full name',
                  //   prefixIcon: const Icon(Icons.person_outline),
                  //   keyboardType: TextInputType.name,
                  //   errorText: null,
                  // ),
                  // const SizedBox(height: 16),

                  // Email
                  Text(
                    'E-mail address',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FTTextFormField(
                    onChanged: (String value) {
                      context.read<AuthBloc>().add(EmailTextChanged(value));
                    },
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.mail_outline),
                    keyboardType: TextInputType.emailAddress,
                    errorText: emailError,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  Text(
                    'Password',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FTTextFormField(
                    onChanged: (String value) {
                      context.read<AuthBloc>().add(PasswordTextChanged(value));
                    },
                    hintText: 'Create a password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    keyboardType: TextInputType.visiblePassword,
                    errorText: passwordError,
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 16),

                  // Confirm password
                  Text(
                    'Confirm password',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FTTextFormField(
                    onChanged: (String value) {
                      context.read<AuthBloc>().add(ConfirmPassword(value));
                    },
                    hintText: 'Repeat your password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    keyboardType: TextInputType.visiblePassword,
                    errorText: confirmPasswordError,
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 24),

                  // Кнопка Register
                  FilledButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(SignUpWithEmail());
                    },
                    child: const Text('Sign up'),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: theme.textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          context.router.push(LoginRoute());
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
