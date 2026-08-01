import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePhotoPicker extends StatelessWidget {
  const ProfilePhotoPicker({
    super.key,
    required this.imageFile,
    required this.imageUrl,
    required this.onTap,
  });

  final File? imageFile;
  final String? imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    ImageProvider? provider;

    if (imageFile != null) {
      provider = FileImage(imageFile!);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      provider = NetworkImage(imageUrl!);
    }

    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(80),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: provider,
              child: provider == null
                  ? const Icon(Icons.person, size: 70)
                  : null,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.camera_alt, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
