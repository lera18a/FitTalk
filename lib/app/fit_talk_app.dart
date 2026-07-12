import 'package:fit_talk/app/auth_listener.dart';
import 'package:fit_talk/core/di/bloc_injector.dart';
import 'package:fit_talk/core/di/dependency_injector_widget.dart';
import 'package:fit_talk/routing/app_router.dart';
import 'package:flutter/material.dart';

class FitTalkApp extends StatelessWidget {
  FitTalkApp({super.key});
  final _router = AppRouter();
  @override
  Widget build(BuildContext context) {
    return DependencyInjectorWidget(
      child: BlocInjector(
        child: MaterialApp.router(
          routerConfig: _router.config(),
          debugShowCheckedModeBanner: false,
          title: 'FitTalk',
          builder: (context, child) =>
              AuthListener(router: _router, child: child!),
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}
