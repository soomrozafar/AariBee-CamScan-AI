class DocumentModel {
  final String title;
  final List<String> images;
  final String? pdfPath;
  final DateTime createdAt;

  bool isFavorite;
  bool isPinned;

  DocumentModel({
    required this.title,
    required this.images,
    this.pdfPath,
    required this.createdAt,
    this.isFavorite = false,
    this.isPinned = false,
  });
}