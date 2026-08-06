// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:fit_talk/feature/settings/settings/presentation/view/pages/profile_photo_screen.dart'
    as _i2;
import 'package:fit_talk/routing/routing.dart' as _i1;
import 'package:flutter/material.dart' as _i4;

/// generated route for
/// [_i1.AutoRouteAchievementsRoute]
class AchievementsRoute extends _i3.PageRouteInfo<void> {
  const AchievementsRoute({List<_i3.PageRouteInfo>? children})
    : super(AchievementsRoute.name, initialChildren: children);

  static const String name = 'AchievementsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteAchievementsRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteAuthRoute]
class AuthRoute extends _i3.PageRouteInfo<void> {
  const AuthRoute({List<_i3.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteAuthRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteChatRoute]
class ChatRoute extends _i3.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i4.Key? key,
    required String chatId,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         ChatRoute.name,
         args: ChatRouteArgs(key: key, chatId: chatId),
         initialChildren: children,
       );

  static const String name = 'ChatRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return _i1.AutoRouteChatRoute(key: args.key, chatId: args.chatId);
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, required this.chatId});

  final _i4.Key? key;

  final String chatId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, chatId: $chatId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatRouteArgs) return false;
    return key == other.key && chatId == other.chatId;
  }

  @override
  int get hashCode => key.hashCode ^ chatId.hashCode;
}

/// generated route for
/// [_i1.AutoRouteChatsListRoute]
class ChatsListRoute extends _i3.PageRouteInfo<void> {
  const ChatsListRoute({List<_i3.PageRouteInfo>? children})
    : super(ChatsListRoute.name, initialChildren: children);

  static const String name = 'ChatsListRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteChatsListRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteFriendsRoute]
class FriendsRoute extends _i3.PageRouteInfo<void> {
  const FriendsRoute({List<_i3.PageRouteInfo>? children})
    : super(FriendsRoute.name, initialChildren: children);

  static const String name = 'FriendsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteFriendsRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteHealthyRoute]
class HealthyRoute extends _i3.PageRouteInfo<void> {
  const HealthyRoute({List<_i3.PageRouteInfo>? children})
    : super(HealthyRoute.name, initialChildren: children);

  static const String name = 'HealthyRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteHealthyRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteHomeHostRoute]
class HomeHostRoute extends _i3.PageRouteInfo<void> {
  const HomeHostRoute({List<_i3.PageRouteInfo>? children})
    : super(HomeHostRoute.name, initialChildren: children);

  static const String name = 'HomeHostRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteHomeHostRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteLoginRoute]
class LoginRoute extends _i3.PageRouteInfo<void> {
  const LoginRoute({List<_i3.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteLoginRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteProfileInfoRoute]
class ProfileInfoRoute extends _i3.PageRouteInfo<ProfileInfoRouteArgs> {
  ProfileInfoRoute({
    _i4.Key? key,
    required String userId,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         ProfileInfoRoute.name,
         args: ProfileInfoRouteArgs(key: key, userId: userId),
         initialChildren: children,
       );

  static const String name = 'ProfileInfoRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileInfoRouteArgs>();
      return _i1.AutoRouteProfileInfoRoute(key: args.key, userId: args.userId);
    },
  );
}

class ProfileInfoRouteArgs {
  const ProfileInfoRouteArgs({this.key, required this.userId});

  final _i4.Key? key;

  final String userId;

  @override
  String toString() {
    return 'ProfileInfoRouteArgs{key: $key, userId: $userId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileInfoRouteArgs) return false;
    return key == other.key && userId == other.userId;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode;
}

/// generated route for
/// [_i1.AutoRouteProfilePhotoRoute]
class ProfilePhotoRoute extends _i3.PageRouteInfo<void> {
  const ProfilePhotoRoute({List<_i3.PageRouteInfo>? children})
    : super(ProfilePhotoRoute.name, initialChildren: children);

  static const String name = 'ProfilePhotoRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteProfilePhotoRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteProfileSetupRoute]
class ProfileSetupRoute extends _i3.PageRouteInfo<void> {
  const ProfileSetupRoute({List<_i3.PageRouteInfo>? children})
    : super(ProfileSetupRoute.name, initialChildren: children);

  static const String name = 'ProfileSetupRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteProfileSetupRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteProfileSetupWrapperRoute]
class ProfileSetupWrapperRoute extends _i3.PageRouteInfo<void> {
  const ProfileSetupWrapperRoute({List<_i3.PageRouteInfo>? children})
    : super(ProfileSetupWrapperRoute.name, initialChildren: children);

  static const String name = 'ProfileSetupWrapperRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteProfileSetupWrapperRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteRegisterRoute]
class RegisterRoute extends _i3.PageRouteInfo<void> {
  const RegisterRoute({List<_i3.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteRegisterRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteSettingsProfileWrapperRoute]
class SettingsProfileWrapperRoute extends _i3.PageRouteInfo<void> {
  const SettingsProfileWrapperRoute({List<_i3.PageRouteInfo>? children})
    : super(SettingsProfileWrapperRoute.name, initialChildren: children);

  static const String name = 'SettingsProfileWrapperRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteSettingsProfileWrapperRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteSettingsRoute]
class SettingsRoute extends _i3.PageRouteInfo<void> {
  const SettingsRoute({List<_i3.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteSettingsRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteThemeSettingsRoute]
class ThemeSettingsRoute extends _i3.PageRouteInfo<void> {
  const ThemeSettingsRoute({List<_i3.PageRouteInfo>? children})
    : super(ThemeSettingsRoute.name, initialChildren: children);

  static const String name = 'ThemeSettingsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteThemeSettingsRoute();
    },
  );
}

/// generated route for
/// [_i2.ProfilePhotoScreen]
class ProfilePhotoScreen extends _i3.PageRouteInfo<void> {
  const ProfilePhotoScreen({List<_i3.PageRouteInfo>? children})
    : super(ProfilePhotoScreen.name, initialChildren: children);

  static const String name = 'ProfilePhotoScreen';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.ProfilePhotoScreen();
    },
  );
}
