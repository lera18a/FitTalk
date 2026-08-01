import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:fit_talk/feature/settings/settings/presentation/bloc/bloc/settings_profile_bloc.dart';
import 'package:fit_talk/feature/settings/settings/presentation/view/widgets/profile_photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class ProfilePhotoScreen extends StatefulWidget {
  const ProfilePhotoScreen({super.key});

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1000,
      maxHeight: 1000,
    );

    if (file == null) return;

    setState(() {
      _selectedImage = File(file.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Фото профиля')),
      body: BlocBuilder<SettingsProfileBloc, SettingsProfileState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (message) => Center(child: Text(message)),
            loaded: (profile) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    ProfilePhotoPicker(
                      imageFile: _selectedImage,
                      imageUrl: profile.avatarUrl,
                      onTap: _pickImage,
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _selectedImage == null
                            ? null
                            : () {
                                context.read<SettingsProfileBloc>().add(
                                  SettingsProfileEvent.updateAvatar(
                                    _selectedImage!,
                                  ),
                                );
                              },
                        child: const Text('Сохранить'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
