import 'package:fit_talk/app/app_lifecicle.dart';
import 'package:fit_talk/feature/auth/data/auth_repository_impl.dart';
import 'package:fit_talk/feature/auth/data/datasources/supabase_datasource.dart';
import 'package:fit_talk/feature/auth/domain/auth_repository.dart';
import 'package:fit_talk/feature/auth/domain/use_cases/request_otp.dart';
import 'package:fit_talk/feature/auth/domain/use_cases/verify_otp.dart';
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
        Provider(create: (context) => RequestOtpUseCase(context.read())),
        Provider(create: (context) => VerifyOtpUseCase(context.read())),
      ],
      child: widget._child,
    );
  }
}
