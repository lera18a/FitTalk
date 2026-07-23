import 'package:auto_route/auto_route.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fit_talk/routing/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      // Пользователь авторизован
      resolver.next(true);
    } else {
      // Пользователь не авторизован
      resolver.redirectUntil(const LoginRoute());
    }
  }
}
