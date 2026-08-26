import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/book.dart';

class BookStorageService {
  static const String _booksKey = 'books';

  // Save all books
  static Future<void> saveBooks(List<Book> books) async {
    final prefs = await SharedPreferences.getInstance();

    final booksJson = books
        .map((book) => book.toJson())
        .toList();

    final jsonString = jsonEncode(booksJson);

    final success = await prefs.setString(
      _booksKey,
      jsonString,
    );

    debugPrint('BOOKS SAVED: ${books.length}');
    debugPrint('SAVE SUCCESS: $success');
    debugPrint('DATA: $jsonString');
  }

  // Load all saved books
  static Future<List<Book>> loadBooks() async {
    final prefs = await SharedPreferences.getInstance();

    final booksString = prefs.getString(_booksKey);

    debugPrint('STORED DATA: $booksString');

    if (booksString == null || booksString.isEmpty) {
      debugPrint('NO SAVED BOOKS FOUND');
      return [];
    }

    try {
      final decodedData = jsonDecode(booksString);

      if (decodedData is! List) {
        debugPrint('INVALID BOOK DATA');
        return [];
      }

      final books = decodedData.map((bookJson) {
        return Book.fromJson(
          Map<String, dynamic>.from(bookJson),
        );
      }).toList();

      debugPrint('BOOKS LOADED: ${books.length}');

      return books;
    } catch (e) {
      debugPrint('ERROR LOADING BOOKS: $e');
      return [];
    }
  }

  // Clear all books
  static Future<void> clearBooks() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_booksKey);

    debugPrint('ALL BOOKS CLEARED');
  }
}