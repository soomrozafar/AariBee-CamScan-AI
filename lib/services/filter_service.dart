
import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FilterService {
  static Future<String> enhanceHD(
    String imagePath,
  ) async {
    final image = await _loadImage(
      imagePath,
    );

    if (image == null) {
      return imagePath;
    }

    final enhanced = img.adjustColor(
      image,
      contrast: 1.20,
      brightness: 1.05,
      saturation: 1.10,
    );

    return _saveImage(
      enhanced,
      "hd",
    );
  }

  static Future<String> blackWhite(
    String imagePath,
  ) async {
    final image = await _loadImage(
      imagePath,
    );

    if (image == null) {
      return imagePath;
    }

    final bw =
        img.grayscale(image);

    return _saveImage(
      bw,
      "bw",
    );
  }

  static Future<String> magicColor(
    String imagePath,
  ) async {
    final image = await _loadImage(
      imagePath,
    );

    if (image == null) {
      return imagePath;
    }

    final magic = img.adjustColor(
      image,
      contrast: 1.45,
      brightness: 1.08,
      saturation: 1.35,
    );

    return _saveImage(
      magic,
      "magic",
    );
  }

  static Future<String> shadowRemove(
    String imagePath,
  ) async {
    final image = await _loadImage(
      imagePath,
    );

    if (image == null) {
      return imagePath;
    }

    final cleaned =
        img.adjustColor(
      image,
      contrast: 1.35,
      brightness: 1.18,
      saturation: 1.05,
    );

    return _saveImage(
      cleaned,
      "shadow",
    );
  }

  static Future<img.Image?> _loadImage(
    String imagePath,
  ) async {
    try {
      final bytes =
          await File(
        imagePath,
      ).readAsBytes();

      return img.decodeImage(
        bytes,
      );
    } catch (_) {
      return null;
    }
  }

  static Future<String> _saveImage(
    img.Image image,
    String prefix,
  ) async {
    final dir =
        await getTemporaryDirectory();

    final path = join(
      dir.path,
      "${prefix}_${DateTime.now().millisecondsSinceEpoch}.jpg",
    );

    final file = File(path);

    await file.writeAsBytes(
      img.encodeJpg(
        image,
        quality: 90,
      ),
    );

    return file.path;
  }
}
