import 'package:flutter/material.dart';
import '../models/sample_books.dart';
import '../widgets/book_card.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onBookChanged;

  const HomeScreen({
    super.key,
    this.onBookChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';

  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredBooks = sampleBooks.where((book) {
      final query = searchQuery.trim().toLowerCase();

      final matchesSearch =
          query.isEmpty ||
          book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query) ||
          book.category.toLowerCase().contains(query);

      final matchesCategory =
          selectedCategory == 'All' ||
          book.category.toLowerCase() ==
              selectedCategory.toLowerCase();

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Exchange'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
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
              const Text(
                'Find your next book',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Discover books and exchange them with other readers.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              // Search Bar
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();

                            setState(() {
                              searchQuery = '';
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Categories
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _categoryChip('All'),
                    _categoryChip('Fiction'),
                    _categoryChip('Programming'),
                    _categoryChip('Academic'),
                    _categoryChip('Self Help'),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Book Section Title
              Text(
                searchQuery.isEmpty &&
                        selectedCategory == 'All'
                    ? 'Available Books'
                    : 'Search Results',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 14),

              // Books
              if (filteredBooks.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'No books found.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              else
                ...filteredBooks.map(
                  (book) => BookCard(
                    key: ValueKey(book),
                    book: book,
                    onBookChanged: () {
                      setState(() {});
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Category Chip
  Widget _categoryChip(String title) {
    final isSelected = selectedCategory == title;

    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(title),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedCategory = title;
          });
        },
        selectedColor: const Color(0xFF1E3A5F),
        backgroundColor: const Color(0xFFE8EEF5),
        labelStyle: TextStyle(
          color: isSelected
              ? Colors.white
              : const Color(0xFF1E3A5F),
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide.none,
      ),
    );
  }
}