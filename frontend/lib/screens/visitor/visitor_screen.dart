import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../services/visitor_service.dart';

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key});

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  final visitorController = TextEditingController();
  final hostController = TextEditingController();

  String selectedDate = "";
  String? qrData;
  bool isLoading = false;

 Future<void> generateQR() async {
  if (visitorController.text.isEmpty ||
      hostController.text.isEmpty ||
      selectedDate.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill all fields")),
    );
    return;
  }

  setState(() {
    isLoading = true;
  });

  final result = await VisitorService.createVisitor(
    visitorController.text,
    hostController.text,
    selectedDate,
  );

  print("API RESULT: $result"); // ✅ correct place

  setState(() {
    isLoading = false;
  });

  if (result != null) {
    setState(() {
      qrData = result['qrCode'];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("QR Generated")),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error generating QR")),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Visitor QR"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Generate Visitor Pass",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: visitorController,
                decoration: InputDecoration(
                  labelText: "Visitor Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: hostController,
                decoration: InputDecoration(
                  labelText: "Host Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: pickDate,
                child: Text(selectedDate.isEmpty
                    ? "Select Date"
                    : selectedDate),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : generateQR,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Generate QR"),
                ),
              ),

              const SizedBox(height: 30),

              if (qrData != null)
                Column(
                  children: [
                    const Text(
                      "Visitor QR",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    QrImageView(
                      data: qrData!,
                      size: 200,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}