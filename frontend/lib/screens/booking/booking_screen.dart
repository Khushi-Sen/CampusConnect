import 'package:flutter/material.dart';
import '../../services/booking_service.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String selectedRoom = "Room 101";
  String selectedDate = "";
  String selectedTime = "";

  final userController = TextEditingController();

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked.format(context);
      });
    }
  }

  Future<void> bookRoom() async {
    if (userController.text.isEmpty ||
        selectedDate.isEmpty ||
        selectedTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill all fields")),
      );
      return;
    }

    final success = await BookingService.createBooking(
      selectedRoom,
      userController.text,
      selectedDate,
      selectedTime,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booking Requested")),
      );

      setState(() {
        selectedDate = "";
        selectedTime = "";
        userController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error")),
      );
    }
  }

  Widget buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book a Room"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🏫 ROOM SELECT
            buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Room",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedRoom,
                    items: ["Room 101", "Room 102", "Lab 1"]
                        .map((room) => DropdownMenuItem(
                              value: room,
                              child: Text(room),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedRoom = val!;
                      });
                    },
                    decoration: const InputDecoration(),
                  ),
                ],
              ),
            ),

            // 👤 NAME
            buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Name",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: userController,
                    decoration: const InputDecoration(
                      hintText: "Enter your name",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ],
              ),
            ),

            // 📅 DATE
            buildCard(
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text("Select Date"),
                subtitle: Text(
                  selectedDate.isEmpty ? "Choose date" : selectedDate,
                ),
                onTap: pickDate,
              ),
            ),

            // ⏰ TIME
            buildCard(
              child: ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text("Select Time"),
                subtitle: Text(
                  selectedTime.isEmpty ? "Choose time" : selectedTime,
                ),
                onTap: pickTime,
              ),
            ),

            const SizedBox(height: 20),

            // 🔘 BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: bookRoom,
                child: const Text(
                  "Book Room",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}