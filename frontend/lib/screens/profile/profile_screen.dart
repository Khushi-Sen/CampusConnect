import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget buildOption(
      {required IconData icon,
      required String title,
      VoidCallback? onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20),

            // 👤 PROFILE HEADER
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 10),

            const Text(
              "Khushi", // 🔁 later dynamic
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "khushi@email.com",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            const Divider(),

            // ⚙️ OPTIONS
            buildOption(
              icon: Icons.person_outline,
              title: "Edit Profile",
            ),
            buildOption(
              icon: Icons.notifications_none,
              title: "Notifications",
            ),
            buildOption(
              icon: Icons.lock_outline,
              title: "Privacy & Security",
            ),
            buildOption(
              icon: Icons.help_outline,
              title: "Help & Support",
            ),

            const Divider(),

            // 🚪 LOGOUT
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red.shade50,
                child: const Icon(Icons.logout, color: Colors.red),
              ),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () => logout(context),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}