import 'dart:convert';
import 'package:http/http.dart' as http;

class VisitorService {
  static const String baseUrl = "http://192.168.1.5:5000/api/visitor";

  // ✅ CREATE VISITOR
  static Future<Map<String, dynamic>?> createVisitor(
      String visitorName, String hostName, String date) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "visitorName": visitorName,
          "hostName": hostName,
          "date": date,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("ERROR: $e");
      return null;
    }
  }

  // ✅ VALIDATE VISITOR
  static Future<Map<String, dynamic>?> validateVisitor(
      String qrCode) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/validate/$qrCode'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("ERROR: $e");
      return null;
    }
  }
}