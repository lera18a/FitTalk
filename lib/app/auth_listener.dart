import 'package:fit_talk/feature/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fit_talk/routing/app_router.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// * When we check the state of this bloc in others places
/// - For example:
///  1) unauthenticated
///  2) authenticated
///  - We also replace in the same route because listener listen. Wow, what the suprase, close right? He listen the state.
///  - How we can help `listenWhen`?
///   He is compare the current state with previous.
///   If they the same listen don't rebuild the state
class AuthListener extends StatelessWidget {
  const AuthListener({super.key, required this.router, required this.child});
  final AppRouter router;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        debugPrint('🔄 AuthListener previous: $previous');
        debugPrint('🔄 AuthListener current: $current');
        return previous != current;
      },
      listener: (context, state) {
        switch (state) {
          case AuthInitial(:final errorMessage):
            debugPrint('🟡 AuthInitial received');
            debugPrint('🟡 General error: $errorMessage');

            if (errorMessage != null) {
              debugPrint('🔴 Showing SnackBar: $errorMessage');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }

          case AuthSuccess():
            router.replaceAll([HomeHostRoute()]);
          case AuthFailure(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message ?? 'Ошибка',
                  style: const TextStyle(color: Colors.red),
                ),
                backgroundColor: Colors.red,
              ),
            );
          // case AuthOtpSend():
          //   router.push(VerificateOtpRoute());
          case AuthLoggedOut():
            router.replaceAll([const AuthRoute()]);
        }
      },
      child: child,
    );
  }
}
