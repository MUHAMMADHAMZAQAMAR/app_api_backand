// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../utils/constants.dart';

class ApiService {
  // ---------- SIGNUP ----------
  static Future<Map<String, dynamic>> signup(
      String name, String email, String password) async {
    final url = Uri.parse('${Constants.baseUrl}/signup.php');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    return jsonDecode(response.body);
  }

  // ---------- LOGIN ----------
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${Constants.baseUrl}/login.php');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return jsonDecode(response.body);
  }

  // ---------- GET ALL USERS ----------
  static Future<List<User>> getAllUsers() async {
    final url = Uri.parse('${Constants.baseUrl}/users.php');
    final response = await http.get(url);

    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => User.fromJson(e)).toList();
  }
}