import '../models/book.dart';
import '../models/sample_books.dart';
import 'book_storage_service.dart';

class BookDataService {
  static List<Book> books = [];

  static Future<void> initialize() async {
    final savedBooks = await BookStorageService.loadBooks();

    if (savedBooks.isNotEmpty) {
      books = savedBooks;
    } else {
      books = List<Book>.from(defaultBooks);

      await BookStorageService.saveBooks(books);
    }
  }

  static Future<void> addBook(Book book) async {
    books.add(book);
    await BookStorageService.saveBooks(books);
  }

  static Future<void> removeBook(Book book) async {
    books.remove(book);
    await BookStorageService.saveBooks(books);
  }

  static Future<void> updateBook(Book book) async {
    await BookStorageService.saveBooks(books);
  }

  static Future<void> saveChanges() async {
    await BookStorageService.saveBooks(books);
  }
}