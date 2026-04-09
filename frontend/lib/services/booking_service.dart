import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingService {
  static const String baseUrl = "http://192.168.1.5:5000/api/booking";

  static Future<bool> createBooking(
      String room, String user, String date, String time) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "roomName": room,
        "userName": user,
        "date": date,
        "time": time,
      }),
    )
        .timeout(const Duration(seconds: 10));

    return response.statusCode == 201;
  }
}