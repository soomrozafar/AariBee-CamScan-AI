import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanState {
  final List<String> images;

  ScanState({required this.images});

  ScanState copyWith({List<String>? images}) {
    return ScanState(images: images ?? this.images);
  }
}

class ScanNotifier extends StateNotifier<ScanState> {
  ScanNotifier() : super(ScanState(images: []));

  void addImage(String path) {
    state = state.copyWith(images: [...state.images, path]);
  }

  void clear() {
    state = state.copyWith(images: []);
  }
}

final scanProvider = StateNotifierProvider<ScanNotifier, ScanState>(
  (ref) => ScanNotifier(),
);
