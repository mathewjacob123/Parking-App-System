import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.10:8080"; // Replace with your backend URL

  // Function to create a user
  Future<void> createUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/users');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        print("User created successfully: ${response.body}");
      } else {
        print("Failed to create user: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Function to fetch all users
  Future<List<dynamic>> getUsers() async {
    final url = Uri.parse('$baseUrl/users');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Failed to fetch users: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
