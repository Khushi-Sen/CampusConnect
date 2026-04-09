import 'package:flutter/material.dart';
import '../../services/faculty_service.dart';

class FacultyLookupScreen extends StatefulWidget {
  const FacultyLookupScreen({super.key});

  @override
  State<FacultyLookupScreen> createState() => _FacultyLookupScreenState();
}

class _FacultyLookupScreenState extends State<FacultyLookupScreen> {
  final controller = TextEditingController();

  Map<String, dynamic>? faculty;

  // 🔍 SEARCH FUNCTION
  Future<void> searchFaculty() async {
    final result = await FacultyService.getFaculty(controller.text.trim());

    if (result != null) {
      setState(() {
        faculty = result;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Faculty not found")),
      );
    }
  }

  // 📅 GET TODAY
  String getToday() {
    final now = DateTime.now();
    return [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday"
    ][now.weekday - 1];
  }

  // 🧠 SMART STATUS FUNCTION
  String getCurrentStatus(Map<String, dynamic> faculty) {
    final now = TimeOfDay.now();
    final today = getToday();

    final todaySchedule = faculty['timetable'][today];

    if (todaySchedule == null || todaySchedule.isEmpty) {
      return "🟢 Free (In Cabin)";
    }

    for (var item in todaySchedule) {
      final timeRange = item['time']; // "09:00-10:00"

      final parts = timeRange.split("-");
      final start = parts[0];
      final end = parts[1];

      final startParts = start.split(":");
      final endParts = end.split(":");

      final startTime = TimeOfDay(
        hour: int.parse(startParts[0]),
        minute: int.parse(startParts[1]),
      );

      final endTime = TimeOfDay(
        hour: int.parse(endParts[0]),
        minute: int.parse(endParts[1]),
      );

      bool isAfterStart = (now.hour > startTime.hour) ||
          (now.hour == startTime.hour && now.minute >= startTime.minute);

      bool isBeforeEnd = (now.hour < endTime.hour) ||
          (now.hour == endTime.hour && now.minute <= endTime.minute);

      if (isAfterStart && isBeforeEnd) {
        return "🔴 In Class (${item['room']})";
      }
    }

    return "🟢 Free (In Cabin)";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Faculty Lookup")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔍 INPUT
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter Faculty ID (e.g. FAC101)",
              ),
            ),

            const SizedBox(height: 10),

            // 🔘 BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: searchFaculty,
                child: const Text("Search"),
              ),
            ),

            const SizedBox(height: 20),

            // 📊 RESULT
            if (faculty != null)
              Expanded(
                child: ListView(
                  children: [

                    // 👤 NAME
                    Text(
                      faculty!['name'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // 🏢 CABIN
                    Text(
                      "Cabin: ${faculty!['cabin']}",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 15),

                    // 🔥 SMART STATUS
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        getCurrentStatus(faculty!),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 📅 TODAY SCHEDULE
                    const Text(
                      "Today's Schedule",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    ...((faculty!['timetable'][getToday()] ?? []) as List)
                        .map(
                      (item) => Card(
                        child: ListTile(
                          leading: const Icon(Icons.access_time),
                          title: Text(item['time']),
                          subtitle: Text(item['room']),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}