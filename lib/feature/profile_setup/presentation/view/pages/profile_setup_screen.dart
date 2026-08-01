import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/core/widgets/f_t_agreement_text.dart';
import 'package:fit_talk/core/widgets/f_t_text_form_field.dart';
import 'package:fit_talk/feature/profile_setup/presentation/bloc/bloc/profile_bloc.dart';
import 'package:fit_talk/feature/profile_setup/presentation/view/widgets/avatar_picker.dart';
import 'package:fit_talk/routing/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _usernameController = TextEditingController();

  Uint8List? _avatarBytes;
  bool _isSaving = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid) return;

    if (_avatarBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Добавьте фотографию профиля')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Следующим шагом здесь подключим ProfileBloc:
      //
      // 1. загрузим _avatarBytes в Storage;
      // 2. получим avatarUrl;
      // 3. сохраним имя, ник и avatarUrl в profiles.

      await Future<void>.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Форма заполнена')));
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заполнение профиля'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) {
            return previous.status != current.status;
          },
          listener: (context, state) {
            switch (state.status) {
              case ProfileSetupStatus.initial:
                Center(child: CircularProgressIndicator());
              case ProfileSetupStatus.loading:
                Center(child: CircularProgressIndicator());
              case ProfileSetupStatus.success:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Профиль успешно сохранен!')),
                );
                context.router.replaceAll([HomeHostRoute()]);
              case ProfileSetupStatus.failure:
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              FTAgreementText(text: 'Имя, ник и фотография обязательны'),
              const SizedBox(height: 32),

              BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) =>
                    previous.avatarBytes != current.avatarBytes,
                builder: (context, state) {
                  return AvatarPicker(
                    imageBytes: state.avatarBytes,
                    onImageSelected: (bytes) {
                      context.read<ProfileBloc>().add(
                        ProfileEvent.avatarChanged(bytes),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 32),

              BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) =>
                    previous.firstName != current.firstName ||
                    previous.status != current.status,
                builder: (context, state) {
                  return FTTextFormField(
                    label: 'Имя',
                    hintText: 'Введите имя',
                    prefixIcon: const Icon(Icons.person_outline),
                    errorText: state.status == ProfileSetupStatus.failure
                        ? state.firstNameError
                        : null,
                    onChanged: (String value) {
                      context.read<ProfileBloc>().add(
                        ProfileEvent.firstNameChanged(value),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) =>
                    previous.username != current.username ||
                    previous.status != current.status,
                builder: (context, state) {
                  return FTTextFormField(
                    label: 'nickname',
                    hintText: 'Lebron_423',
                    prefixIcon: const Icon(Icons.alternate_email),
                    errorText: state.status == ProfileSetupStatus.failure
                        ? state.usernameError
                        : null,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                        ProfileEvent.usernameChanged(value),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 32),
              BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  final isLoading = state.status == ProfileSetupStatus.loading;

                  return FilledButton(
                    onPressed: isLoading
                        ? null
                        : () => context.read<ProfileBloc>().add(
                            const ProfileEvent.saveProfileSubmitted(),
                          ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Сохранить'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
