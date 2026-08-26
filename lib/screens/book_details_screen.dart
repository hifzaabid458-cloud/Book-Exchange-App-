import 'package:flutter/material.dart';
import '../models/book.dart';
import 'exchange_request_screen.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailsScreen> createState() =>
      _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  Book get book => widget.book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                book.isSaved = !book.isSaved;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    book.isSaved
                        ? 'Book saved successfully!'
                        : 'Book removed from saved books.',
                  ),
                ),
              );
            },
            icon: Icon(
              book.isSaved
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================
              // BOOK IMAGE
              // =====================================================

              Container(
                width: double.infinity,
                height: 260,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1E8DB),
                  borderRadius: BorderRadius.circular(20),
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
                      size: 100,
                      color: Color(0xFF1E3A5F),
                    );
                  },
                )
                    : const Icon(
                  Icons.menu_book_rounded,
                  size: 100,
                  color: Color(0xFF1E3A5F),
                ),
              ),

              const SizedBox(height: 24),

              // =====================================================
              // BOOK TITLE
              // =====================================================

              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 8),

              // =====================================================
              // AUTHOR
              // =====================================================

              Text(
                'by ${book.author}',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              // =====================================================
              // INFORMATION CHIPS
              // =====================================================

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _infoChip(
                    Icons.category_outlined,
                    book.category,
                  ),
                  _infoChip(
                    Icons.star_border,
                    book.condition,
                  ),
                  _infoChip(
                    Icons.location_on_outlined,
                    book.location,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =====================================================
              // DESCRIPTION
              // =====================================================

              const Text(
                'About this book',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                book.description.isEmpty
                    ? 'No description provided.'
                    : book.description,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 32),

              // =====================================================
              // REQUEST EXCHANGE
              // =====================================================

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExchangeRequestScreen(
                              book: book,
                            ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.swap_horiz_rounded,
                  ),
                  label: const Text(
                    'Request Exchange',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // INFORMATION CHIP
  // ===============================================================

  Widget _infoChip(
      IconData icon,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EEF5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 17,
            color: const Color(0xFF1E3A5F),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E3A5F),
            ),
          ),
        ],
      ),
    );
  }
}