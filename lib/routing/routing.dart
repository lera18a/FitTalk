import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/feature/%D1%81hat/chat_screen.dart';
import 'package:fit_talk/feature/achivements/presentation/view/pages/achivements_screen.dart';
import 'package:fit_talk/feature/auth/presentation/view/pages/login_screen.dart';
import 'package:fit_talk/feature/auth/presentation/view/pages/register_screen.dart';
import 'package:fit_talk/feature/friends/presentation/view/pages/profile_info_screen.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/widgets/profile_setup_wrapper.dart';
import 'package:fit_talk/feature/settings/settings/presentation/view/pages/profile_photo_screen.dart';
import 'package:fit_talk/feature/settings/settings/presentation/view/pages/settings_screen.dart';
import 'package:fit_talk/feature/friends/presentation/view/pages/friends_screen.dart';
import 'package:fit_talk/feature/healthy/presentation/view/pages/healthy_screen.dart';
import 'package:fit_talk/feature/home/home.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/pages/profile_setup_screen.dart';
import 'package:fit_talk/feature/settings/settings/presentation/view/widgets/settings_profile_wrapper.dart';
import 'package:fit_talk/feature/settings/theme/presentation/view/pages/theme_settings_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AutoRouteAuthRoute extends AutoRouter {
  const AutoRouteAuthRoute({super.key});
}

// @RoutePage()
// class AutoRouteHomeHostRoute extends AutoRouter {
//   const AutoRouteHomeHostRoute({super.key});
// }

@RoutePage()
class AutoRouteHomeHostRoute extends StatelessWidget {
  const AutoRouteHomeHostRoute({super.key});
  @override
  Widget build(BuildContext context) => HomeScreen();
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
class AutoRouteProfileSetupRoute extends StatelessWidget {
  const AutoRouteProfileSetupRoute({super.key});

  @override
  Widget build(BuildContext context) => ProfileSetupScreen();
}

// @RoutePage()
// class AutoRouteHomeRoute extends StatelessWidget {
//   const AutoRouteHomeRoute({super.key, required this.child});
//   final Widget child;
//   @override
//   Widget build(BuildContext context) => HomeScreen();
// }

@RoutePage()
class AutoRouteSettingsRoute extends StatelessWidget {
  const AutoRouteSettingsRoute({super.key});

  @override
  Widget build(BuildContext context) => SettingsScreen();
}

@RoutePage()
class AutoRouteFriendsRoute extends StatelessWidget {
  const AutoRouteFriendsRoute({super.key});
  @override
  Widget build(BuildContext context) => FriendsScreen();
}

@RoutePage()
class AutoRouteHealthyRoute extends StatelessWidget {
  const AutoRouteHealthyRoute({super.key});
  @override
  Widget build(BuildContext context) => HealthyScreen();
}

@RoutePage()
class AutoRouteAchievementsRoute extends StatelessWidget {
  const AutoRouteAchievementsRoute({super.key});
  @override
  Widget build(BuildContext context) => AchivementsScreen();
}

@RoutePage()
class AutoRouteChatsRoute extends StatelessWidget {
  const AutoRouteChatsRoute({super.key});
  @override
  Widget build(BuildContext context) => ChatScreen();
}

@RoutePage()
class AutoRouteProfilePhotoRoute extends StatelessWidget {
  const AutoRouteProfilePhotoRoute({super.key});
  @override
  Widget build(BuildContext context) => ProfilePhotoScreen();
}

@RoutePage()
class AutoRouteProfileSetupWrapperRoute extends StatelessWidget {
  const AutoRouteProfileSetupWrapperRoute({super.key});
  @override
  Widget build(BuildContext context) => ProfileSetupWrapper();
}

@RoutePage()
class AutoRouteSettingsProfileWrapperRoute extends StatelessWidget {
  const AutoRouteSettingsProfileWrapperRoute({super.key});
  @override
  Widget build(BuildContext context) => SettingsProfileWrapper();
}

@RoutePage()
class AutoRouteThemeSettingsRoute extends StatelessWidget {
  const AutoRouteThemeSettingsRoute({super.key});
  @override
  Widget build(BuildContext context) => ThemeSettingsScreen();
}

@RoutePage()
class AutoRouteProfileInfoRoute extends StatelessWidget {
  const AutoRouteProfileInfoRoute({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) => ProfileInfoScreen(userId: userId);
}
