import 'dart:io';

import 'package:flutter/material.dart';

import '../services/filter_service.dart';

class FilterPreviewScreen extends StatefulWidget {
  final String imagePath;

  const FilterPreviewScreen({super.key, required this.imagePath});

  @override
  State<FilterPreviewScreen> createState() => _FilterPreviewScreenState();
}

class _FilterPreviewScreenState extends State<FilterPreviewScreen> {
  bool isLoading = true;

  String selectedImage = "";

  final Map<String, String> filters = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      generateFilters();
    });
  }

  Future<void> generateFilters() async {
    try {
      final bw = await FilterService.blackWhite(widget.imagePath);

      final magic = await FilterService.magicColor(widget.imagePath);

      final shadow = await FilterService.shadowRemove(widget.imagePath);

      filters["Original"] = widget.imagePath;

      filters["Black & White"] = bw;

      filters["Magic Color"] = magic;

      filters["Shadow Remove"] = shadow;

      selectedImage = magic;

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Filter Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Filters")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.file(
                        File(selectedImage),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(14),
                    children: filters.entries.map((entry) {
                      final isSelected = selectedImage == entry.value;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = entry.value;
                          });
                        },
                        child: Container(
                          width: 110,
                          margin: const EdgeInsets.only(right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.cyan
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    File(entry.value),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  entry.key,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle),
                    label: const Text("Apply Selected Filter"),
                    onPressed: () {
                      Navigator.pop(context, selectedImage);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
