import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tutorschool/widget/registration/add_location_widget.dart';
import 'package:tutorschool/widget/registration/details_registration_page.dart';
import 'package:tutorschool/widget/registration/education_details_widget.dart';

import '../global_state.dart';
import '../utils/appconfig.dart';
import 'home_page_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

// Sign-in with Google - Helper Method
Future<GoogleSignInAccount?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      return googleUser;
    } else {
      print("Google sign-in cancelled");
      return null;
    }
  } catch (e) {
    print("Error during Google sign-in: $e");
    return null;
  }
}

// Sign-Up with Google
Future<void> signUpWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await signInWithGoogle();
  if (googleUser != null) {
    try {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Pass the ID token to your backend API
      final response = await http.post(
        Uri.parse(ApiEndpoints.google),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': googleAuth.idToken}),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsRegistrationWidget()),
        );
      } else {
        showErrorDialog(context, "Google sign-up failed: ${response.body}");
      }
    } catch (e) {
      showErrorDialog(context, 'Error during Google sign-up: $e');
    }
  }
}

// Login with Google
Future<void> loginWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await signInWithGoogle();
  if (googleUser != null) {
    try {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Pass the ID token to your backend API
      final response = await http.post(
        Uri.parse(ApiEndpoints.google),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': googleAuth.idToken}),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardWidget()),
        );
      } else {
        showErrorDialog(context, "Google login failed: ${response.body}");
      }
    } catch (e) {
      showErrorDialog(context, 'Error during Google login: $e');
    }
  }
}

// OTP sending validation
bool isPhoneNumberValid(String phone) {
  return phone.length == 10 && RegExp(r'^[0-9]+$').hasMatch(phone);
}

// Send OTP
Future<void> sendOtp(String phone, BuildContext context) async {
  if (!isPhoneNumberValid(phone)) {
    showErrorDialog(context, "Invalid phone number. Please check and try again.");
    return;
  }

  try {
    final response = await http.post(
      Uri.parse(ApiEndpoints.start),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['message'] == 'otp sent successfully') {
        print("OTP Sent: ${data['otp']}");
      } else {
        showErrorDialog(context, "Unexpected response: ${data['message']}");
      }
    } else {
      showErrorDialog(context, "Failed to send OTP. Status code: ${response.statusCode}");
    }
  } catch (e) {
    showErrorDialog(context, "Error sending OTP: $e");
  }
}

// Verify OTP
Future<void> verifyOtp(String phone, String otp, BuildContext context) async {
  final accessHash = generateAccessHash(phone, otp);
  try {
    final response = await http.post(
      Uri.parse(ApiEndpoints.verify),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'otp': otp, 'access_hash': accessHash}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['message'] == 'phone verified successfully') {
        GlobalData.accessHash = data['access_hash'];
        print("OTP Verified successfully");
        print("Access Hash: ${GlobalData.accessHash}");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsRegistrationWidget()),
        );
      } else {
        showErrorDialog(context, 'Invalid OTP. Please try again.');
      }
    } else {
      showErrorDialog(context, 'Failed to verify OTP. Status code: ${response.statusCode}');
    }
  } catch (e) {
    showErrorDialog(context, 'An error occurred. Please try again.');
  }
}

// Show error dialog
void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

// Login with phone and password
Future<void> login(String phone, String password, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(ApiEndpoints.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['message'] == 'Teacher logged in successfully') {
        GlobalData.jwtToken = data['jwt_token'] ?? '';
        GlobalData.goToDashboard = data['go_to_dashboard'] ?? false;
        GlobalData.model = data['model'] ?? '';

        if (data['teacher'] != null) {
          GlobalData.teacher.updateTeacher(data['teacher']);
        }

        if (GlobalData.teacher.location.isEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LocationPickerWidget(isTeacher: true),
            ),
          );
        } else {
          if (GlobalData.goToDashboard) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardWidget()),
            );
          } else {
            showErrorDialog(context, "You need to complete onboarding.");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EducationDetails()),
            );
          }
        }
      } else {
        showErrorDialog(context, "Entered username or password is wrong.");
      }
    } else {
      showErrorDialog(context, "Entered username or password is wrong.");
    }
  } catch (e) {
    showErrorDialog(context, 'An error occurred during login: $e');
  }
}

// Generate Access Hash
String generateAccessHash(String phone, String otp) {
  return 'hashed_${phone}_$otp';
}
