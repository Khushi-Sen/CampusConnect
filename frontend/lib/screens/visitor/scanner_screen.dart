import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../services/visitor_service.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool isScanning = true;

  Future<void> validateQR(String code) async {
    if (!isScanning) return;

    setState(() {
      isScanning = false;
    });

    final result = await VisitorService.validateVisitor(code);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(result != null ? "Access Granted ✅" : "Invalid QR ❌"),
        content: Text(
          result != null
              ? "Visitor: ${result['visitorName']}\nHost: ${result['hostName']}"
              : "This QR code is not valid",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                isScanning = true;
              });
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Visitor QR"),
      ),
      body: Stack(
        children: [

          // 📷 CAMERA
          MobileScanner(
            onDetect: (barcodeCapture) {
              final barcodes = barcodeCapture.barcodes;

              for (final barcode in barcodes) {
                final String? code = barcode.rawValue;

                if (code != null) {
                  validateQR(code);
                  break;
                }
              }
            },
          ),

          // 🎯 SCAN BOX OVERLAY
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // 📘 INSTRUCTIONS
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: const [
                Text(
                  "Align QR inside the box",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "Scanning will happen automatically",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}