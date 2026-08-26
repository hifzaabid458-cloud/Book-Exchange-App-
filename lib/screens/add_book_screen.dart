import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/sample_books.dart';
import '../services/book_storage_service.dart';

class AddBookScreen extends StatefulWidget {
  final Book? bookToEdit;
  final int? bookIndex;
  final VoidCallback? onBookSaved;

  const AddBookScreen({
    super.key,
    this.bookToEdit,
    this.bookIndex,
    this.onBookSaved,
  });

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController =
  TextEditingController();

  final TextEditingController _authorController =
  TextEditingController();

  final TextEditingController _locationController =
  TextEditingController();

  final TextEditingController _descriptionController =
  TextEditingController();

  // NEW: Book image URL
  final TextEditingController _imageUrlController =
  TextEditingController();

  String selectedCategory = 'Fiction';
  String selectedCondition = 'Good';

  bool get isEditing => widget.bookToEdit != null;

  @override
  void initState() {
    super.initState();

    if (widget.bookToEdit != null) {
      final book = widget.bookToEdit!;

      _titleController.text = book.title;
      _authorController.text = book.author;
      _locationController.text = book.location;
      _descriptionController.text = book.description;

      // Load existing image URL when editing.
      _imageUrlController.text = book.imageUrl;

      selectedCategory = book.category;
      selectedCondition = book.condition;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Book' : 'Add a Book',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEditing ? 'Edit Your Book' : 'List Your Book',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  isEditing
                      ? 'Update your book information.'
                      : 'Add your book details so other readers can find it.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 24),

                // ==================== BOOK TITLE ====================

                _buildLabel('Book Title'),

                TextFormField(
                  controller: _titleController,
                  decoration: _inputDecoration(
                    'Enter book title',
                    Icons.menu_book_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the book title';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // ==================== AUTHOR ====================

                _buildLabel('Author'),

                TextFormField(
                  controller: _authorController,
                  decoration: _inputDecoration(
                    'Enter author name',
                    Icons.person_outline,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the author name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // ==================== CATEGORY ====================

                _buildLabel('Category'),

                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: _inputDecoration(
                    'Select category',
                    Icons.category_outlined,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Fiction',
                      child: Text('Fiction'),
                    ),
                    DropdownMenuItem(
                      value: 'Programming',
                      child: Text('Programming'),
                    ),
                    DropdownMenuItem(
                      value: 'Academic',
                      child: Text('Academic'),
                    ),
                    DropdownMenuItem(
                      value: 'Self Help',
                      child: Text('Self Help'),
                    ),
                    DropdownMenuItem(
                      value: 'Other',
                      child: Text('Other'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 18),

                // ==================== CONDITION ====================

                _buildLabel('Book Condition'),

                DropdownButtonFormField<String>(
                  value: selectedCondition,
                  decoration: _inputDecoration(
                    'Select condition',
                    Icons.star_border,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Like New',
                      child: Text('Like New'),
                    ),
                    DropdownMenuItem(
                      value: 'Good',
                      child: Text('Good'),
                    ),
                    DropdownMenuItem(
                      value: 'Used',
                      child: Text('Used'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCondition = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 18),

                // ==================== LOCATION ====================

                _buildLabel('Location'),

                TextFormField(
                  controller: _locationController,
                  decoration: _inputDecoration(
                    'e.g. Lahore',
                    Icons.location_on_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // ==================== DESCRIPTION ====================

                _buildLabel('Description'),

                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: _inputDecoration(
                    'Tell readers about the book...',
                    Icons.description_outlined,
                  ),
                ),

                const SizedBox(height: 18),

                // ==================== IMAGE URL ====================

                _buildLabel('Book Cover Image URL'),

                TextFormField(
                  controller: _imageUrlController,
                  keyboardType: TextInputType.url,
                  decoration: _inputDecoration(
                    'Paste book cover image URL',
                    Icons.image_outlined,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Optional: paste an online image URL for the book cover.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 28),

                // ==================== SAVE BUTTON ====================

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _saveBook,
                    icon: Icon(
                      isEditing
                          ? Icons.save_outlined
                          : Icons.add,
                    ),
                    label: Text(
                      isEditing
                          ? 'Save Changes'
                          : 'Add Book',
                      style: const TextStyle(
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
      ),
    );
  }

  // ============================================================
  // SAVE BOOK
  // ============================================================

  Future<void> _saveBook() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (isEditing) {
      final book = widget.bookToEdit!;

      book.title = _titleController.text.trim();
      book.author = _authorController.text.trim();
      book.category = selectedCategory;
      book.condition = selectedCondition;
      book.location = _locationController.text.trim();
      book.description = _descriptionController.text.trim();

      // Update image URL.
      book.imageUrl = _imageUrlController.text.trim();

      await BookStorageService.saveBooks(sampleBooks);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Book updated successfully!',
          ),
        ),
      );
    } else {
      final newBook = Book(
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        category: selectedCategory,
        condition: selectedCondition,
        location: _locationController.text.trim(),

        // Save image URL.
        imageUrl: _imageUrlController.text.trim(),

        description: _descriptionController.text.trim(),
      );

      sampleBooks.add(newBook);

      await BookStorageService.saveBooks(sampleBooks);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Book added successfully!',
          ),
        ),
      );
    }

    // Tell MainNavigation that the book was saved.
    widget.onBookSaved?.call();

    // Only pop when this screen was opened using Navigator.push().
    if (widget.onBookSaved == null && mounted) {
      Navigator.pop(context);
    }
  }

  // ============================================================
  // LABEL
  // ============================================================

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
      ),
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration(
      String hint,
      IconData icon,
      ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}