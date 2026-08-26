import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ==================== PREFERENCES ====================

          const Text(
            'Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                // ==================== NOTIFICATIONS ====================

                SwitchListTile(
                  secondary: const Icon(
                    Icons.notifications_outlined,
                  ),
                  title: const Text(
                    'Notifications',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    'Receive exchange request notifications',
                  ),
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),

                const Divider(height: 1),

                // ==================== DARK MODE ====================

                ValueListenableBuilder<bool>(
                  valueListenable: AppTheme.isDarkMode,
                  builder: (context, isDarkMode, child) {
                    return SwitchListTile(
                      secondary: Icon(
                        isDarkMode
                            ? Icons.dark_mode
                            : Icons.dark_mode_outlined,
                      ),
                      title: const Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                        'Use dark theme throughout the app',
                      ),
                      value: isDarkMode,
                      onChanged: (value) {
                        AppTheme.isDarkMode.value = value;
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ==================== ACCOUNT ====================

          const Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                // ==================== EDIT PROFILE ====================

                ListTile(
                  leading: const Icon(
                    Icons.person_outline,
                  ),
                  title: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    'Update your profile information',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const EditProfileScreen(),
                      ),
                    );
                  },
                ),

                const Divider(height: 1),

                // ==================== CHANGE PASSWORD ====================

                ListTile(
                  leading: const Icon(
                    Icons.lock_outline,
                  ),
                  title: const Text(
                    'Change Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    'Update your account password',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const ChangePasswordScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ==================== ABOUT ====================

          const Text(
            'About',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.info_outline,
              ),
              title: const Text(
                'About Book Exchange',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                'Learn more about the app',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Book Exchange',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(
                    Icons.menu_book_rounded,
                    size: 40,
                  ),
                  children: const [
                    Text(
                      'A peer-to-peer platform where users can '
                          'exchange books with other readers.',
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // ==================== VERSION ====================

          Center(
            child: Text(
              'Book Exchange • Version 1.0.0',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}