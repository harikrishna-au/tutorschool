import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginVerificationModel {
  final String apiUrl = 'https://backend-oy4r.onrender.com/auth/teacher/login';

  Future<bool> login(String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Login successful
        final responseBody = jsonDecode(response.body);
        print('Login successful: $responseBody');
        return true;
      } else {
        // Login failed
        print('Login failed: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
      return false;
    }
  }
}
