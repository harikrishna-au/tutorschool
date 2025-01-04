import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../utils/appconfig.dart'; // Import API configuration

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool isOtpSent = false;
  String phoneNumber = '';
  String otp = '';

  // Function to generate hash for verification
  String generateHash(String phone, String otp) {
    final secretKey = 'YourSecretKey'; // Replace with your secure secret key
    final combined = '$phone|$otp|$secretKey';
    return sha256.convert(utf8.encode(combined)).toString();
  }

  // Function to show error dialog
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error', style: TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  // Function to send OTP
  Future<void> sendOtp(String phone) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.start), // Use endpoint from appconfig
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message'] == 'otp sent successfully') {
          setState(() {
            isOtpSent = true;
          });
        } else {
          showErrorDialog(data['message']);
        }
      } else {
        showErrorDialog('Error: ${response.statusCode}');
      }
    } catch (e) {
      showErrorDialog(e.toString());
    }
  }

  // Function to verify OTP
  Future<void> verifyOtp(String phone, String otp) async {
    final hash = generateHash(phone, otp);
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.verify), // Use endpoint from appconfig
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone, 'otp': otp, 'access_hash': hash}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message'] == 'phone verified successfully') {
          Navigator.pushNamed(context, '/detailsRegistration');
        } else {
          showErrorDialog(data['message']);
        }
      } else {
        showErrorDialog('Verification failed: ${response.statusCode}');
      }
    } catch (e) {
      showErrorDialog(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tutor Signup',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) => phoneNumber = value,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter phone number',
            ),
          ),
          if (isOtpSent) ...[
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => otp = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter OTP',
              ),
            ),
          ],
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (isOtpSent) {
                verifyOtp(phoneNumber, otp);
              } else {
                sendOtp(phoneNumber);
              }
            },
            child: Text(isOtpSent ? 'Verify OTP' : 'Send OTP'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tutor Signup'),
          backgroundColor: Colors.green,
        ),
        body: SignUpWidget(),
      ),
      routes: {
        '/detailsRegistration': (context) => DetailsRegistrationPage(),
      },
    ),
  );
}

// Placeholder for DetailsRegistrationPage
class DetailsRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Registration')),
      body: Center(child: Text('Details Registration Page')),
    );
  }
}
