import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:fit_talk/routing/routes.dart';

@AutoRouterConfig(replaceInRouteName: 'AutoRoute,')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/auth',
      page: AuthRoute.page,
      initial: true,
      children: [
        AutoRoute(page: LoginRoute.page, path: '', initial: true),
        AutoRoute(page: RegisterRoute.page, path: Routes.register),
        // AutoRoute(page: SendOtpRoute.page, path: Routes.sendOtp),
        // AutoRoute(page: VerificateOtpRoute.page, path: Routes.verificateOtp),
      ],
    ),
    AutoRoute(
      path: Routes.host,
      page: HomeHostRoute.page,
      children: [AutoRoute(page: SettingsRoute.page, path: '', initial: true)],
    ),
  ];
}
