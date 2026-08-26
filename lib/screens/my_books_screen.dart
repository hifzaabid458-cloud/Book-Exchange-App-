import 'package:flutter/material.dart';
import '../models/sample_books.dart';
import '../widgets/book_card.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  void _refreshBooks() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final myBooks = sampleBooks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
      ),

      body: SafeArea(
        child: myBooks.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        size: 70,
                        color: Colors.grey,
                      ),

                      SizedBox(height: 16),

                      Text(
                        'No Books Yet',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Books you add will appear here.',
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
                itemCount: myBooks.length,
                itemBuilder: (context, index) {
                  final book = myBooks[index];

                  return BookCard(
                    key: ValueKey(book),
                    book: book,
                    bookIndex: index,
                    onBookChanged: _refreshBooks,
                  );
                },
              ),
      ),
    );
  }
}