import 'package:flutter/material.dart';
import 'my_books_screen.dart';
import 'exchange_requests_screen.dart';
import 'location_screen.dart';
import 'settings_screen.dart';
import '../services/auth_storage_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),

      body: SafeArea(
        child: FutureBuilder<String>(
          future: AuthStorageService.getUserName(),
          builder: (context, snapshot) {
            final userName =
                snapshot.data ?? 'Book Exchange User';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // ==================== PROFILE AVATAR ====================

                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8EEF5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 55,
                      color: Color(0xFF1E3A5F),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ==================== NAME ====================

                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),

                  const SizedBox(height: 6),

                  FutureBuilder<String>(
                    future: AuthStorageService.getUserEmail(),
                    builder: (context, emailSnapshot) {
                      return Text(
                        emailSnapshot.data ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  // ==================== MY BOOKS ====================

                  _profileOption(
                    icon: Icons.menu_book_outlined,
                    title: 'My Books',
                    subtitle: 'Manage the books you listed',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const MyBooksScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // ==================== EXCHANGE REQUESTS ====================

                  _profileOption(
                    icon: Icons.swap_horiz_rounded,
                    title: 'Exchange Requests',
                    subtitle: 'View your exchange requests',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const ExchangeRequestsScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // ==================== LOCATION ====================

                  _profileOption(
                    icon: Icons.location_on_outlined,
                    title: 'Location',
                    subtitle: 'Manage your preferred location',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const LocationScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // ==================== SETTINGS ====================

                  _profileOption(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    subtitle: 'Manage app preferences',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const SettingsScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  // ==================== APP INFORMATION ====================

                  const Text(
                    'Book Exchange',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3A5F),
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Share books. Discover stories. Connect with readers.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _profileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFE8EEF5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF1E3A5F),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}