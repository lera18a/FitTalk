import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:fit_talk/feature/settings/settings/presentation/bloc/bloc/settings_profile_bloc.dart';
import 'package:fit_talk/feature/settings/settings/presentation/view/pages/settings_screen.dart';
import 'package:fit_talk/feature/settings/theme/presentation/bloc/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsProfileWrapper extends StatelessWidget {
  const SettingsProfileWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsProfileBloc(
            profileRepository: context.read<ProfileRepository>(),
            client: context.read<SupabaseClient>(),
          ),
        ),
      ],
      child: AutoRouter(),
    );
  }
}
