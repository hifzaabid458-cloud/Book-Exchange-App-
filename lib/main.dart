import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';
import 'models/sample_books.dart';
import 'services/book_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ONE-TIME RESET: removes old books with empty image URLs.
  await BookStorageService.clearBooks();

  await loadBooksFromStorage();

  runApp(const BookExchangeApp());
}

class BookExchangeApp extends StatelessWidget {
  const BookExchangeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Exchange',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}