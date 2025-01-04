
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/appconfig.dart';
class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String phoneNumber = '';
  String password = '';

  Future<void> login(String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'phone': phone, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message'] == 'Teacher logged in successfully') {
          // Handle successful login
        } else {
          showErrorDialog("Login failed: ${data['message']}");
        }
      } else {
        showErrorDialog('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      showErrorDialog('An error occurred during login: $e');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error', style: TextStyle(color: Colors.red)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => phoneNumber = value,
          decoration: InputDecoration(
            hintText: 'Enter phone number',
          ),
        ),
        TextField(
          obscureText: true,
          onChanged: (value) => password = value,
          decoration: InputDecoration(
            hintText: 'Enter password',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            login(phoneNumber, password);
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
