import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://192.168.1.5:5000/api/auth";

  // ✅ LOGIN
  static Future<Map<String, dynamic>?> login(
      String email, String password) async {
 final response = await http
    .post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    )
    .timeout(const Duration(seconds: 10));
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  // ✅ SIGNUP (INSIDE CLASS)
  static Future<Map<String, dynamic>?> signup(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "role": role,
      }),
    )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
      return null;
    
  }
}