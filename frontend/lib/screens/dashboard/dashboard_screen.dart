import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation/navigation_screen.dart';
import'../faculty/faculty_lookup_screen.dart';
import '../visitor/visitor_screen.dart';
import '../canteen/canteen_screen.dart';
import '../booking/booking_screen.dart';
import '../visitor/scanner_screen.dart';
import '../ar/ar_test_Screen.dart';
import '../profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String role = "student";

  @override
  void initState() {
    super.initState();
    loadRole();
  }

  void loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role') ?? "student";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("CampusConnect"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [

            // 🎓 STUDENT FEATURES
            if (role == "student") _buildCard(context, "Navigate", Icons.map),
            if (role == "student") _buildCard(context, "Faculty", Icons.person),
            if (role == "student") _buildCard(context, "Visitor", Icons.qr_code),
            if (role == "student") _buildCard(context, "Canteen", Icons.fastfood),
            if (role == "student") _buildCard(context, "Booking", Icons.meeting_room),

            // 🛡 SECURITY FEATURE
            if (role == "security") _buildCard(context, "Scan QR", Icons.qr_code_scanner),

            // 👤 COMMON
            _buildCard(context, "Profile", Icons.account_circle),
          ],
        ),
      ),
    );
  }
    // ElevatedButton(
    //   onPressed: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => ARTestScreen()),
    //     );
    //   },
    //   child: Text('Test AR'),
    // )
  Widget _buildCard(
      BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Widget screen;

        switch (title) {
          case "Navigate":
            screen = const NavigationScreen();
            break;
          case "Faculty":
            screen = const FacultyLookupScreen(); 
            break;
          case "Visitor":
            screen = const VisitorScreen();
            break;
          case "Scan QR":
            screen = const ScannerScreen();
            break;
          case "Canteen":
            screen = const CanteenScreen();
            break;
          case "Booking":
            screen = const BookingScreen();
            break;
          case "Profile":
            screen = const ProfileScreen();
            break;
          case "AR":
            screen =  ARTestScreen();
          default:
            return;
        }

        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => screen,
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },

      

      // 🎨 UI CARD DESIGN
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}