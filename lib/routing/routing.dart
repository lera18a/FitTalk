import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/feature/auth/presentation/view/pages/login_screen.dart';
import 'package:fit_talk/feature/auth/presentation/view/pages/register_screen.dart';
import 'package:fit_talk/feature/auth/presentation/view/pages/settings_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AutoRouteAuthRoute extends AutoRouter {
  const AutoRouteAuthRoute({super.key});
}

@RoutePage()
class AutoRouteHomeHostRoute extends AutoRouter {
  const AutoRouteHomeHostRoute({super.key});
}

@RoutePage()
class AutoRouteLoginRoute extends StatelessWidget {
  const AutoRouteLoginRoute({super.key});

  @override
  Widget build(BuildContext context) => LoginScreen();
}

@RoutePage()
class AutoRouteRegisterRoute extends StatelessWidget {
  const AutoRouteRegisterRoute({super.key});

  @override
  Widget build(BuildContext context) => RegisterScreen();
}

@RoutePage()
class AutoRouteSettingsRoute extends StatelessWidget {
  const AutoRouteSettingsRoute({super.key});

  @override
  Widget build(BuildContext context) => SettingsScreen();
}
