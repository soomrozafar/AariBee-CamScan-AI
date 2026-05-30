import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SaveService {
  static Future<String> saveScan(String originalPath) async {
    final dir = await getApplicationDocumentsDirectory();

    final scanDir = Directory(join(dir.path, "AariBeeCamScan"));

    if (!await scanDir.exists()) {
      await scanDir.create(recursive: true);
    }

    final fileName = "SCAN_${DateTime.now().millisecondsSinceEpoch}.jpg";

    final savedPath = join(scanDir.path, fileName);

    final savedFile = await File(originalPath).copy(savedPath);

    return savedFile.path;
  }
}
