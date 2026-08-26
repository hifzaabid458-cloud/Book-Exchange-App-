import 'book.dart';
import '../services/book_storage_service.dart';

List<Book> sampleBooks = [];

final List<Book> defaultBooks = [
  Book(
    title: 'The Alchemist',
    author: 'Paulo Coelho',
    category: 'Fiction',
    condition: 'Good',
    location: 'Lahore',
    imageUrl: 'assets/the_alchemist.jpeg',
  ),

  Book(
    title: 'Clean Code',
    author: 'Robert C. Martin',
    category: 'Programming',
    condition: 'Like New',
    location: 'Islamabad',
    imageUrl: 'assets/clean_code.jpeg',
  ),

  Book(
    title: 'Atomic Habits',
    author: 'James Clear',
    category: 'Self Help',
    condition: 'Good',
    location: 'Rawalpindi',
    imageUrl: 'assets/atomic_habits.jpeg',
  ),

  Book(
    title: 'Introduction to Algorithms',
    author: 'Thomas H. Cormen',
    category: 'Academic',
    condition: 'Used',
    location: 'Faisalabad',
    imageUrl: 'assets/introduction_to_algorithms.jpeg',
  ),
];

Future<void> loadBooksFromStorage() async {
  final savedBooks = await BookStorageService.loadBooks();

  if (savedBooks.isEmpty) {
    sampleBooks = List<Book>.from(defaultBooks);

    await BookStorageService.saveBooks(sampleBooks);
  } else {
    sampleBooks = List<Book>.from(savedBooks);
  }
}

Future<void> saveBooksToStorage() async {
  await BookStorageService.saveBooks(sampleBooks);
}