import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/sample_books.dart';
import '../screens/add_book_screen.dart';
import '../screens/book_details_screen.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final int? bookIndex;
  final VoidCallback? onBookChanged;

  const BookCard({
    super.key,
    required this.book,
    this.bookIndex,
    this.onBookChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsScreen(
                book: book,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // =====================================================
              // BOOK IMAGE
              // =====================================================

              Container(
                width: 85,
                height: 110,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1E8DB),
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: book.imageUrl.trim().isNotEmpty
                    ? Image.asset(
                  book.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) {
                    return const Icon(
                      Icons.menu_book_rounded,
                      size: 42,
                      color: Color(0xFF1E3A5F),
                    );
                  },
                )
                    : const Icon(
                  Icons.menu_book_rounded,
                  size: 42,
                  color: Color(0xFF1E3A5F),
                ),
              ),

              const SizedBox(width: 14),

              // =====================================================
              // BOOK INFORMATION
              // =====================================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      book.author,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      book.category,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E3A5F),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            book.location,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // =================================================
                    // EDIT & DELETE
                    // =================================================

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddBookScreen(
                                      bookToEdit: book,
                                      bookIndex: bookIndex,
                                    ),
                              ),
                            );

                            if (context.mounted) {
                              onBookChanged?.call();
                            }
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            size: 16,
                          ),
                          label: const Text('Edit'),
                        ),

                        const SizedBox(width: 8),

                        OutlinedButton.icon(
                          onPressed: () {
                            _showDeleteDialog(context);
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            size: 16,
                          ),
                          label: const Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // DELETE DIALOG
  // ===============================================================

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Book?'),

          content: Text(
            'Are you sure you want to delete "${book.title}"?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                if (sampleBooks.contains(book)) {
                  sampleBooks.remove(book);

                  onBookChanged?.call();
                }

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Book deleted successfully!',
                    ),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}