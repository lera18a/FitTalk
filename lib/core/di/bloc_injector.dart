import 'package:fit_talk/feature/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fit_talk/feature/settings/theme/presentation/bloc/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocInjector extends StatelessWidget {
  const BlocInjector({super.key, required Widget child}) : _child = child;
  final Widget _child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(
          create: (context) => AuthBloc(
            emailValidator: context.read(),
            passwordValidator: context.read(),
            authRepository: context.read(),
            // requestOtpUseCase: context.read(),
            // verifyOtpUseCase: context.read(),
          ),
        ),

        // BlocProvider(
        //   create: (context) => ProfileBloc(profileRepository: context.read()),
        // ),
        // BlocProvider(
        //   create: (context) => SettingsProfileBloc(
        //     profileRepository: context.read<ProfileRepository>(),
        //     client: context.read<SupabaseClient>(),
        //   ),
        // ),
      ],
      child: _child,
    );
  }
}
