import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFService {
  static Future<File> generatePDF(List<String> images) async {
    final pdf = pw.Document();

    for (final imagePath in images) {
      final image = pw.MemoryImage(File(imagePath).readAsBytesSync());

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Center(child: pw.Image(image, fit: pw.BoxFit.contain));
          },
        ),
      );
    }

    final dir = await getApplicationDocumentsDirectory();

    final pdfDir = Directory(join(dir.path, "AariBeeCamScanPDF"));

    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }

    final fileName = "SCAN_${DateTime.now().millisecondsSinceEpoch}.pdf";

    final file = File(join(pdfDir.path, fileName));

    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
