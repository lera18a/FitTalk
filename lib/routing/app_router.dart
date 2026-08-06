import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/core/guards/auth_guard.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:fit_talk/routing/routes.dart';

@AutoRouterConfig(replaceInRouteName: 'AutoRoute,')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/auth',
      page: AuthRoute.page,
      children: [
        AutoRoute(page: LoginRoute.page, path: '', initial: true),
        AutoRoute(page: RegisterRoute.page, path: Routes.register),
        // AutoRoute(page: SendOtpRoute.page, path: Routes.sendOtp),
        // AutoRoute(page: VerificateOtpRoute.page, path: Routes.verificateOtp),
      ],
    ),
    AutoRoute(path: Routes.setupProfile, page: ProfileSetupWrapperRoute.page),
    AutoRoute(
      path: Routes.host,
      initial: true,
      page: HomeHostRoute.page,
      guards: [AuthGuard()],
      children: [
        AutoRoute(page: FriendsRoute.page, path: Routes.friends),
        AutoRoute(page: HealthyRoute.page, path: Routes.healthy),
        AutoRoute(page: AchievementsRoute.page, path: Routes.achievements),

        // ChatRoute(chatId: chatId),
        AutoRoute(
          page: ChatsListRoute.page,
          path: Routes.chats,
          children: [AutoRoute(page: ChatRoute.page, path: '', initial: true)],
        ),
        AutoRoute(
          page: SettingsProfileWrapperRoute.page,
          path: '',
          initial: true,
          children: [
            AutoRoute(page: SettingsRoute.page, path: '', initial: true),
            AutoRoute(page: ProfilePhotoRoute.page, path: Routes.profilePhoto),
          ],
        ),
      ],
    ),
    AutoRoute(page: ChatRoute.page, path: Routes.chat),

    AutoRoute(page: ThemeSettingsRoute.page, path: Routes.themeSettings),
    AutoRoute(page: ProfileInfoRoute.page, path: Routes.profileInfo),
  ];
}
