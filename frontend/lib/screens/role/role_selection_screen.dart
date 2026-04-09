import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../visitor/visitor_home.dart';
import '../faculty/faculty_lookup_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "CampusConnect",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            buildButton(context, "Student", Icons.school, const LoginScreen()),
            buildButton(context, "Security", Icons.security, const LoginScreen()),
            buildButton(context, "Visitor", Icons.person, const VisitorHome()),
            buildButton(context, "Faculty", Icons.badge, const FacultyLookupScreen()),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      BuildContext context, String title, IconData icon, Widget screen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: Icon(icon),
          label: Text(title),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => screen),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}