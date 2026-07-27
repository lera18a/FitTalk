import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatelessWidget {
  const AvatarPicker({
    super.key,
    required this.imageBytes,
    required this.onImageSelected,
  });

  final Uint8List? imageBytes;
  final ValueChanged<Uint8List> onImageSelected;

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1000,
      maxHeight: 1000,
    );

    if (file == null) return;

    final bytes = await file.readAsBytes();
    onImageSelected(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: _pickImage,
        borderRadius: BorderRadius.circular(70),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 65,
              backgroundImage: imageBytes != null
                  ? MemoryImage(imageBytes!)
                  : null,
              child: imageBytes == null
                  ? const Icon(Icons.person, size: 64)
                  : null,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 20,
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
