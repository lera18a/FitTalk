import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

abstract class ImageCompressor {
  /// Сжимает [Uint8List] байты изображения до нужного качества и формата JPG.
  /// Принимает исходные байты и целевой файл, куда сохранить результат.
  static Future<File> compressBytesToFile({
    required Uint8List bytes,
    required File targetFile,
    int quality = 70, // Оптимальное сжатие без видимой потери качества
  }) async {
    // 1. Декодируем байты в объект изображения
    final image = img.decodeImage(bytes);
    if (image == null) throw Exception('Не удалось декодировать изображение');

    // 2. Если картинка огромная, уменьшаем её разрешение (например, максимум 1024px по большой стороне)
    img.Image resizedImage = image;
    if (image.width > 1024 || image.height > 1024) {
      resizedImage = img.copyResize(
        image,
        width: image.width > image.height ? 1024 : null,
        height: image.height >= image.width ? 1024 : null,
      );
    }

    // 3. Кодируем в JPG сжатого качества
    final compressedBytes = img.encodeJpg(resizedImage, quality: quality);

    // 4. Записываем в итоговый файл
    return await targetFile.writeAsBytes(compressedBytes);
  }
}
