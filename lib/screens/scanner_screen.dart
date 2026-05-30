import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'preview_screen.dart';
import '../providers/scan_provider.dart';
import '../services/save_service.dart';
import '../services/scanner_service.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Document")),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton.icon(
                icon: const Icon(Icons.document_scanner_rounded),
                label: const Text("Start AI Scan"),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  try {
                    final images = await ScannerService.scanDocuments();

                    final notifier = ref.read(scanProvider.notifier);

                    for (final path in images) {
                      final saved = await SaveService.saveScan(path);

                      notifier.addImage(saved);
                    }

                    if (!mounted) {
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PreviewScreen()),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${images.length} documents scanned successfully",
                        ),
                      ),
                    );
                  } catch (e) {
                    debugPrint("Scanner Error: $e");
                  } finally {
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
              ),
      ),
    );
  }
}
