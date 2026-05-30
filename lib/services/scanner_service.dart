import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

class ScannerService {
  static Future<List<String>> scanDocuments() async {
    try {
      final options = DocumentScannerOptions(
        mode: ScannerMode.full,
        pageLimit: 20,
      );

      final scanner = DocumentScanner(
        options: options,
      );

      final result = await scanner.scanDocument();

      return result.images ?? [];
    } catch (_) {
      return [];
    }
  }
}
