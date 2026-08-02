import 'package:fit_talk/app/app_lifecicle.dart';
import 'package:fit_talk/feature/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:fit_talk/feature/auth/data/datasources/supabase_datasource.dart';
import 'package:fit_talk/feature/auth/domain/repository/auth_repository.dart';
import 'package:fit_talk/feature/auth/domain/use_cases/email_validator.dart';
import 'package:fit_talk/feature/auth/domain/use_cases/password_validator.dart';
import 'package:fit_talk/feature/friends/data/datasource/friends_datasource.dart';
import 'package:fit_talk/feature/friends/data/repository_impl/friends_repository_impl.dart';
import 'package:fit_talk/feature/friends/domain/repository/friends_repository.dart';
import 'package:fit_talk/feature/profile_setup/data/datasource/supabase_datasource_profile.dart';
import 'package:fit_talk/feature/profile_setup/data/repoditory_impl/profile_repository_impl.dart';
import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DependencyInjectorWidget extends StatefulWidget {
  const DependencyInjectorWidget({super.key, required Widget child})
    : _child = child;
  final Widget _child;
  // static AppLifecicle appLificecle = AppLifecicle();
  @override
  State<DependencyInjectorWidget> createState() =>
      _DependencyInjectorWidgetState();
}

class _DependencyInjectorWidgetState extends State<DependencyInjectorWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AppLifecicle()),
        Provider(create: (context) => Supabase.instance.client),
        Provider(
          create: (context) => SupabaseDatasource(client: context.read()),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(supabase: context.read()),
        ),
        Provider(create: (context) => EmailValidatorUseCase()),
        Provider(create: (context) => PasswordValidatorUseCase()),

        // PROFILE
        // ------------------------------------------
        Provider(
          create: (context) =>
              SupabaseDatasourceProfile(client: context.read<SupabaseClient>()),
        ),
        Provider<ProfileRepository>(
          create: (context) =>
              ProfileRepositoryImpl(context.read<SupabaseDatasourceProfile>()),
        ),

        Provider(
          create: (context) =>
              FriendsDatasource(context.read<SupabaseClient>()),
        ),
        Provider<FriendsRepository>(
          create: (context) => FriendsRepositoryImpl(
            context.read<FriendsDatasource>(),
            context.read<SupabaseClient>(),
          ),
        ),
      ],
      child: widget._child,
    );
  }
}
