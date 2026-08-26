import 'package:flutter/material.dart';
import '../models/sample_books.dart';
import '../widgets/book_card.dart';

class SavedBooksScreen extends StatefulWidget {
  const SavedBooksScreen({super.key});

  @override
  State<SavedBooksScreen> createState() =>
      _SavedBooksScreenState();
}

class _SavedBooksScreenState
    extends State<SavedBooksScreen> {

  void _refreshSavedBooks() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final savedBooks = sampleBooks
        .where((book) => book.isSaved)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Books'),
      ),

      body: SafeArea(
        child: savedBooks.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 70,
                        color: Colors.grey,
                      ),

                      SizedBox(height: 16),

                      Text(
                        'No Saved Books',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Books you save will appear here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: savedBooks.length,
                itemBuilder: (context, index) {
                  final book = savedBooks[index];

                  return BookCard(
                    key: ValueKey(book),
                    book: book,
                    onBookChanged: _refreshSavedBooks,
                  );
                },
              ),
      ),
    );
  }
}