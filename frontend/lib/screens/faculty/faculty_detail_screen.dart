import 'package:flutter/material.dart';

class FacultyDetailScreen extends StatelessWidget {
  final Map faculty;

  const FacultyDetailScreen({super.key, required this.faculty});

  @override
  Widget build(BuildContext context) {
    Color statusColor =
        faculty['status'] == "Free" ? Colors.green : Colors.orange;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(faculty['name']),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.person, size: 80, color: Colors.blue),
            const SizedBox(height: 20),

            Text(
              faculty['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              faculty['department'],
              style: const TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 20),

            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                faculty['status'],
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 5),
                Text(
                  faculty['location'],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}