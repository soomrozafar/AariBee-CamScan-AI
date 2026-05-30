
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';

import '../providers/document_provider.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() =>
      _LibraryScreenState();
}

class _LibraryScreenState
    extends ConsumerState<LibraryScreen> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final documents =
        ref.watch(documentProvider);

    final filtered =
        documents.where((doc) {
      return doc.title
          .toLowerCase()
          .contains(
            search.toLowerCase(),
          );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Document Library",
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.all(16),
            child: TextField(
              decoration:
                  InputDecoration(
                hintText:
                    "Search documents...",
                prefixIcon:
                    const Icon(
                  Icons.search,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text(
                      "No Documents",
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets
                            .all(16),
                    itemCount:
                        filtered.length,
                    itemBuilder:
                        (
                      context,
                      index,
                    ) {
                      final doc =
                          filtered[
                              index];

                      return Container(
                        margin:
                            const EdgeInsets
                                .only(
                          bottom: 16,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xff121A2A,
                          ),
                          borderRadius:
                              BorderRadius
                                  .circular(
                            24,
                          ),
                        ),
                        child:
                            ListTile(
                          contentPadding:
                              const EdgeInsets
                                  .all(
                            16,
                          ),
                          leading:
                              CircleAvatar(
                            radius:
                                28,
                            backgroundColor:
                                const Color(
                              0xff00B4D8,
                            ),
                            child:
                                Icon(
                              doc.isPinned
                                  ? Icons
                                      .push_pin
                                  : Icons
                                      .description,
                              color:
                                  Colors
                                      .white,
                            ),
                          ),
                          title:
                              Text(
                            doc.title,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,
                              fontSize:
                                  18,
                            ),
                          ),
                          subtitle:
                              Text(
                            "${doc.images.length} pages",
                          ),
                          trailing:
                              PopupMenuButton<
                                  String>(
                            onSelected:
                                (
                              value,
                            ) async {
                              if (value ==
                                  "favorite") {
                                ref
                                    .read(
                                      documentProvider
                                          .notifier,
                                    )
                                    .toggleFavorite(
                                      doc,
                                    );
                              }

                              if (value ==
                                  "pin") {
                                ref
                                    .read(
                                      documentProvider
                                          .notifier,
                                    )
                                    .togglePinned(
                                      doc,
                                    );
                              }

                              if (value ==
                                  "open") {
                                if (doc.pdfPath !=
                                    null) {
                                  await OpenFilex
                                      .open(
                                    doc.pdfPath!,
                                  );
                                }
                              }

                              if (value ==
                                  "delete") {
                                ref
                                    .read(
                                      documentProvider
                                          .notifier,
                                    )
                                    .deleteDocument(
                                      doc,
                                    );
                              }
                            },
                            itemBuilder:
                                (_) =>
                                    [
                              const PopupMenuItem(
                                value:
                                    "open",
                                child:
                                    Text(
                                  "Open PDF",
                                ),
                              ),
                              const PopupMenuItem(
                                value:
                                    "favorite",
                                child:
                                    Text(
                                  "Favorite",
                                ),
                              ),
                              const PopupMenuItem(
                                value:
                                    "pin",
                                child:
                                    Text(
                                  "Pin",
                                ),
                              ),
                              const PopupMenuItem(
                                value:
                                    "delete",
                                child:
                                    Text(
                                  "Delete",
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

