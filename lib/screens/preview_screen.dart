import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../models/document_model.dart';
import '../providers/document_provider.dart';
import '../providers/scan_provider.dart';
import '../services/gallery_service.dart';
import '../services/pdf_service.dart';
import 'filter_preview_screen.dart';

class PreviewScreen extends ConsumerWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanState = ref.watch(scanProvider);
    final images = scanState.images;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
      ),
      body: Column(
        children: [
          Expanded(
            child: images.isEmpty
                ? const Center(
                    child: Text("No Images"),
                  )
                : ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(14),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(images[index]),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text("AI Enhance Filters"),
                  onPressed: () async {
                    if (images.isEmpty) return;

                    final filtered = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FilterPreviewScreen(
                          imagePath: images.first,
                        ),
                      ),
                    );

                    if (filtered == null) return;

                    if (!context.mounted) return;

                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("AI Recommendation"),
                          content: const Text(
                            "Magic Color recommended for best readability.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text("Export PDF"),
                  onPressed: () async {
                    if (images.isEmpty) return;

                    final pdfFile = await PDFService.generatePDF(images);

                    ref.read(documentProvider.notifier).addDocument(
                          DocumentModel(
                            title:
                                "Scan ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                            images: images,
                            pdfPath: pdfFile.path,
                            createdAt: DateTime.now(),
                          ),
                        );

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "PDF Saved:\n${pdfFile.path}",
                        ),
                      ),
                    );

                    await Share.shareXFiles(
                      [
                        XFile(pdfFile.path),
                      ],
                      text: "Shared from AariBee CamScan AI",
                    );
                  },
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Save JPEG"),
                  onPressed: () async {
                    if (images.isEmpty) return;

                    for (final image in images) {
                      await GalleryService.saveImage(image);
                    }

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Images saved to gallery",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
