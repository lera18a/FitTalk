// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:fit_talk/routing/routing.dart' as _i1;
import 'package:flutter/material.dart' as _i3;

/// generated route for
/// [_i1.AutoRouteAuthRoute]
class AuthRoute extends _i2.PageRouteInfo<void> {
  const AuthRoute({List<_i2.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteAuthRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteOauthRoute]
class OauthRoute extends _i2.PageRouteInfo<void> {
  const OauthRoute({List<_i2.PageRouteInfo>? children})
    : super(OauthRoute.name, initialChildren: children);

  static const String name = 'OauthRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteOauthRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteSendOtpRoute]
class SendOtpRoute extends _i2.PageRouteInfo<void> {
  const SendOtpRoute({List<_i2.PageRouteInfo>? children})
    : super(SendOtpRoute.name, initialChildren: children);

  static const String name = 'SendOtpRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      return const _i1.AutoRouteSendOtpRoute();
    },
  );
}

/// generated route for
/// [_i1.AutoRouteVerificateOtpRoute]
class VerificateOtpRoute extends _i2.PageRouteInfo<VerificateOtpRouteArgs> {
  VerificateOtpRoute({
    _i3.Key? key,
    required String token,
    List<_i2.PageRouteInfo>? children,
  }) : super(
         VerificateOtpRoute.name,
         args: VerificateOtpRouteArgs(key: key, token: token),
         initialChildren: children,
       );

  static const String name = 'VerificateOtpRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerificateOtpRouteArgs>();
      return _i1.AutoRouteVerificateOtpRoute(key: args.key, token: args.token);
    },
  );
}

class VerificateOtpRouteArgs {
  const VerificateOtpRouteArgs({this.key, required this.token});

  final _i3.Key? key;

  final String token;

  @override
  String toString() {
    return 'VerificateOtpRouteArgs{key: $key, token: $token}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VerificateOtpRouteArgs) return false;
    return key == other.key && token == other.token;
  }

  @override
  int get hashCode => key.hashCode ^ token.hashCode;
}
