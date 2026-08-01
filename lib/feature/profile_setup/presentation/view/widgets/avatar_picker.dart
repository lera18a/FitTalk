import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatelessWidget {
  const AvatarPicker({
    super.key,
    this.imageBytes,
    this.imageUrl,
    required this.onImageSelected,
  });

  final Uint8List? imageBytes;
  final String? imageUrl;
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
    ImageProvider? imageProvider;

    if (imageBytes != null) {
      imageProvider = MemoryImage(imageBytes!);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(imageUrl!);
    }

    return Center(
      child: InkWell(
        onTap: _pickImage,
        borderRadius: BorderRadius.circular(70),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 65,
              backgroundImage: imageProvider,
              child: imageProvider == null
                  ? const Icon(Icons.person, size: 64)
                  : null,
            ),
            const Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(radius: 20, child: Icon(Icons.camera_alt)),
            ),
          ],
        ),
      ),
    );
  }
}
