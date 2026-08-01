import 'package:fit_talk/feature/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:fit_talk/feature/profile_setup/presentation/bloc/bloc/profile_bloc.dart';
import 'package:fit_talk/feature/settings/settings/presentation/bloc/bloc/settings_profile_bloc.dart';
import 'package:fit_talk/feature/settings/settings/presentation/view/pages/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlocInjector extends StatelessWidget {
  const BlocInjector({super.key, required Widget child}) : _child = child;
  final Widget _child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
