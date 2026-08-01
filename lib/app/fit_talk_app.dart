import 'package:fit_talk/app/auth_listener.dart';
import 'package:fit_talk/core/di/bloc_injector.dart';
import 'package:fit_talk/core/di/dependency_injector_widget.dart';
import 'package:fit_talk/core/themes/f_t_theme.dart';
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
          themeMode: ThemeMode.system,
          theme: ThemeData(
            textTheme: FTTheme.buildTextTheme(Theme.of(context).textTheme),
          ),
          routerConfig: _router.config(),
          debugShowCheckedModeBanner: false,
          title: 'FitTalk',
          builder: (context, child) =>
              AuthListener(router: _router, child: child!),
        ),
      ),
    );
  }
}
