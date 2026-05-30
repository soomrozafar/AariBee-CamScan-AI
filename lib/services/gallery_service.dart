import 'dart:io';

class GalleryService {
  static Future<void> saveImage(String path) async {
    final file = File(path);

    if (!await file.exists()) {
      return;
    }

    // Placeholder local save
    // We will later replace with
    // scoped storage system
  }
}
