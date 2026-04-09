import 'dart:convert';
import 'package:http/http.dart' as http;

class FacultyService {
  static const String baseUrl = "http://192.168.1.5:5000/api/faculty";

  static Future<Map<String, dynamic>?> getFaculty(String id) async {
    final res = await http.get(Uri.parse("$baseUrl/$id"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    return null;
  }
}