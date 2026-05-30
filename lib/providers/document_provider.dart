
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/document_model.dart';

class DocumentNotifier extends StateNotifier<List<DocumentModel>> {
  DocumentNotifier() : super([]) {
    loadDocuments();
  }

  final Box box = Hive.box('documents');

  void loadDocuments() {
    final docs = <DocumentModel>[];

    for (final item in box.values) {
      docs.add(
        DocumentModel(
          title: item['title'],
          images: List<String>.from(item['images']),
          pdfPath: item['pdfPath'],
          createdAt: DateTime.parse(
            item['createdAt'],
          ),
          isFavorite:
              item['isFavorite'] ?? false,
          isPinned:
              item['isPinned'] ?? false,
        ),
      );
    }

    state = docs.reversed.toList();
  }

  Future<void> addDocument(
    DocumentModel doc,
  ) async {
    await box.add({
      'title': doc.title,
      'images': doc.images,
      'pdfPath': doc.pdfPath,
      'createdAt':
          doc.createdAt.toIso8601String(),
      'isFavorite': doc.isFavorite,
      'isPinned': doc.isPinned,
    });

    loadDocuments();
  }

  Future<void> deleteDocument(
    DocumentModel doc,
  ) async {
    final keyToDelete = box.keys.firstWhere(
      (key) {
        final item = box.get(key);

        return item['createdAt'] ==
            doc.createdAt
                .toIso8601String();
      },
    );

    await box.delete(keyToDelete);

    loadDocuments();
  }

  Future<void> toggleFavorite(
    DocumentModel doc,
  ) async {
    doc.isFavorite =
        !doc.isFavorite;

    loadDocuments();
  }

  Future<void> togglePinned(
    DocumentModel doc,
  ) async {
    doc.isPinned =
        !doc.isPinned;

    loadDocuments();
  }
}

final documentProvider =
    StateNotifierProvider<
      DocumentNotifier,
      List<DocumentModel>
    >(
      (ref) =>
          DocumentNotifier(),
    );
