import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/core/widgets/f_t_text_form_field.dart';
import 'package:fit_talk/feature/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                        'assets/fitTalk-welcome.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .06),
                  Text(
                    'Welcome back!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * .04),

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
                    errorText: emailError,
                    prefixIcon: Icon(Icons.mail),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  FTTextFormField(
                    obscureText: true,
                    onChanged: (String value) {
                      context.read<AuthBloc>().add(PasswordTextChanged(value));
                    },
                    hintText: 'Enter your password',
                    errorText: passwordError,
                    prefixIcon: null,
                    keyboardType: TextInputType.visiblePassword,
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(SignInWithEmail());
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 16),
                  // Sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: theme.textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          context.router.push(RegisterRoute());
                        },
                        child: const Text('Sign up now'),
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
