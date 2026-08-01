import 'package:fit_talk/feature/profile_setup/domain/repository/profile_repository.dart';
import 'package:fit_talk/feature/profile_setup/presentation/bloc/bloc/profile_bloc.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/pages/profile_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSetupWrapper extends StatelessWidget {
  const ProfileSetupWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProfileBloc(profileRepository: context.read<ProfileRepository>()),
      child: const ProfileSetupScreen(),
    );
  }
}
