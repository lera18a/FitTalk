import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/feature/auth/presentation/view/pages/auth_screen.dart';
import 'package:fit_talk/feature/auth/presentation/view/pages/send_otp_screen.dart';
import 'package:fit_talk/feature/auth/presentation/view/pages/settings_screen.dart';
import 'package:fit_talk/feature/auth/presentation/view/pages/verification_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AutoRouteAuthRoute extends AutoRouter {
  const AutoRouteAuthRoute({super.key});
}

@RoutePage()
class AutoRouteOauthRoute extends StatelessWidget {
  const AutoRouteOauthRoute({super.key});

  @override
  Widget build(BuildContext context) => OauthScreen();
}

@RoutePage()
class AutoRouteSendOtpRoute extends StatelessWidget {
  const AutoRouteSendOtpRoute({super.key});

  @override
  Widget build(BuildContext context) => SendOtpScreen();
}

@RoutePage()
class AutoRouteVerificateOtpRoute extends StatelessWidget {
  const AutoRouteVerificateOtpRoute({super.key});

  @override
  Widget build(BuildContext context) => VerificationScreen(key: key);
}

@RoutePage()
class AutoRouteHomeHostRoute extends AutoRouter {
  const AutoRouteHomeHostRoute({super.key});
}

@RoutePage()
class AutoRouteSettingsRoute extends StatelessWidget {
  const AutoRouteSettingsRoute({super.key});

  @override
  Widget build(BuildContext context) => SettingsScreen();
}
