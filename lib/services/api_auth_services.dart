import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiAuthServices {
  static const String baseUrl = "http://192.168.1.6:8080";

  static Future<Map<String, dynamic>> signupUser(
      String username, String password) async {
    final url = Uri.parse('$baseUrl/signup/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to signup user: ${response.statusCode} ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    final url = Uri.parse('$baseUrl/login/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to login user: ${response.statusCode} ${response.body}');
    }
  }

  
}
