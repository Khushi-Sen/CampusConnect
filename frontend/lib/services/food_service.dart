import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodService {
  static const String baseUrl = "http://192.168.1.5:5000/api/food";

  static Future<List<dynamic>> getFood() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }
}