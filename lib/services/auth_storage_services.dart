import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorageService {
  static const String _emailKey = 'user_email';
  static const String _passwordKey = 'user_password';
  static const String _nameKey = 'user_name';
  static const String _loggedInKey = 'user_logged_in';

  // ============================================================
  // INITIALIZE USER
  // ============================================================

  static Future<void> initializeUser() async {
    // No default account.
    // User creates an account through Sign Up.
    await SharedPreferences.getInstance();
  }

  // ============================================================
  // CREATE ACCOUNT
  // ============================================================

  static Future<bool> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final cleanName = name.trim();
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    final existingEmail = prefs.getString(_emailKey);

    // Account already exists.
    if (existingEmail != null &&
        existingEmail.trim().isNotEmpty) {
      debugPrint('CREATE ACCOUNT: Account already exists');
      return false;
    }

    final nameSaved =
    await prefs.setString(_nameKey, cleanName);

    final emailSaved =
    await prefs.setString(_emailKey, cleanEmail);

    final passwordSaved =
    await prefs.setString(_passwordKey, cleanPassword);

    final loginSaved =
    await prefs.setBool(_loggedInKey, false);

    debugPrint('CREATE ACCOUNT');
    debugPrint('Name saved: $nameSaved');
    debugPrint('Email saved: $emailSaved');
    debugPrint('Password saved: $passwordSaved');
    debugPrint('Login state saved: $loginSaved');

    // Verify immediately.
    final savedEmail = prefs.getString(_emailKey);
    final savedPassword = prefs.getString(_passwordKey);

    debugPrint('VERIFY EMAIL: $savedEmail');
    debugPrint(
      'VERIFY PASSWORD EXISTS: ${savedPassword != null}',
    );

    return savedEmail == cleanEmail &&
        savedPassword == cleanPassword;
  }

  // ============================================================
  // LOGIN
  // ============================================================

  static Future<bool> login(
      String email,
      String password,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString(_emailKey);
    final savedPassword = prefs.getString(_passwordKey);

    final enteredEmail =
    email.trim().toLowerCase();

    final enteredPassword =
    password.trim();

    debugPrint('================ LOGIN ================');
    debugPrint('Entered email: $enteredEmail');
    debugPrint('Stored email: $savedEmail');
    debugPrint(
      'Stored password exists: ${savedPassword != null}',
    );

    if (savedEmail == null ||
        savedPassword == null) {
      debugPrint('LOGIN FAILED: No saved account');
      return false;
    }

    if (enteredEmail == savedEmail.toLowerCase() &&
        enteredPassword == savedPassword) {
      await prefs.setBool(
        _loggedInKey,
        true,
      );

      debugPrint('LOGIN SUCCESS');

      return true;
    }

    debugPrint('LOGIN FAILED: Credentials do not match');

    return false;
  }

  // ============================================================
  // CHECK LOGIN
  // ============================================================

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_loggedInKey) ?? false;
  }

  // ============================================================
  // GET USER NAME
  // ============================================================

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_nameKey) ??
        'Book Exchange User';
  }

  // ============================================================
  // GET USER EMAIL
  // ============================================================

  static Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_emailKey) ?? '';
  }

  // ============================================================
  // UPDATE PROFILE
  // ============================================================

  static Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _nameKey,
      name.trim(),
    );

    await prefs.setString(
      _emailKey,
      email.trim().toLowerCase(),
    );

    debugPrint('PROFILE UPDATED');
  }

  // ============================================================
  // CHANGE PASSWORD
  // ============================================================

  static Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final savedPassword =
    prefs.getString(_passwordKey);

    if (savedPassword == null) {
      debugPrint(
        'CHANGE PASSWORD FAILED: No password stored',
      );
      return false;
    }

    if (currentPassword.trim() != savedPassword) {
      debugPrint(
        'CHANGE PASSWORD FAILED: Current password incorrect',
      );
      return false;
    }

    final success = await prefs.setString(
      _passwordKey,
      newPassword.trim(),
    );

    debugPrint(
      'PASSWORD CHANGED: $success',
    );

    return success;
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      _loggedInKey,
      false,
    );

    debugPrint('USER LOGGED OUT');
  }

  // ============================================================
  // RESET ACCOUNT
  // DEVELOPMENT ONLY
  // ============================================================

  static Future<void> resetAccount() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_loggedInKey);

    debugPrint('ACCOUNT RESET');
  }
}