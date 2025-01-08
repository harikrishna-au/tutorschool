import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:tutorschool/widget/registration/add_location_widget.dart';
import 'package:tutorschool/widget/registration/education_details_widget.dart';

import '../global_state.dart';
import '../utils/appconfig.dart';
import 'package:tutorschool/widget/registration/details_registration_page.dart';

import 'home_page_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenticationChoice(),
    );
  }
}

class AuthenticationChoice extends StatefulWidget {
  @override
  _AuthenticationChoiceState createState() => _AuthenticationChoiceState();
}

class _AuthenticationChoiceState extends State<AuthenticationChoice> {
  bool isTeacherSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'TutorSchool',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TutorSignupWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class TutorSignupWidget extends StatefulWidget {
  @override
  _TutorSignupWidgetState createState() => _TutorSignupWidgetState();
}

class _TutorSignupWidgetState extends State<TutorSignupWidget> {
  bool showSignUp = true;
  bool isOtpSent = false;
  String phoneNumber = '';
  String otp = '';
  String password = '';

  String generateAccessHash(String phone, String otp) {
    final secretKey = 'YourSecretKey'; // Use a secure, private key
    final combinedString = '$phone|$otp|$secretKey';
    final bytes = utf8.encode(combinedString);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: Colors.red),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendOtp(String phone) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.start), // Use config for endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'phone': phone}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['message'] == 'otp sent successfully') {
          setState(() {
            isOtpSent = true;
          });
          print("OTP Sent: ${data['otp']}");
        } else {
          showErrorDialog("Unexpected response: ${data['message']}");
        }
      } else {
        showErrorDialog(
            "Failed to send OTP. Status code: ${response.statusCode}");
      }
    } catch (e) {
      showErrorDialog("Error sending OTP: $e");
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    final accessHash = generateAccessHash(phone, otp);
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.verify), // Use config for endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {'phone': phone, 'otp': otp, 'access_hash': accessHash}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['message'] == 'phone verified successfully') {
          GlobalData.accessHash = data['access_hash']; // Save the access hash globally
          print("OTP Verified successfully");
          print("Access Hash: ${GlobalData.accessHash}");
          print("Key to get: ${data['key_to_get']}");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsRegistrationWidget(),
            ),
          );
        }
        else {
          showErrorDialog('Invalid OTP. Please try again.');
        }
      } else {
        showErrorDialog(
            'Failed to verify OTP. Status code: ${response.statusCode}');
      }
    } catch (e) {
      showErrorDialog('An error occurred. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            showSignUp ? 'Tutor Signup' : 'Tutor Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          SizedBox(height: 24),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) => phoneNumber = value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Enter your phone number',
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
            ),
          ),
          if (!showSignUp) ...[
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              onChanged: (value) => password = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter Password',
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
              ),
            ),
          ],
          if (isOtpSent && showSignUp) ...[
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => otp = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter OTP',
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
              ),
            ),
          ],
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (showSignUp) {
                  if (isOtpSent) {
                    verifyOtp(phoneNumber, otp);
                  } else {
                    sendOtp(phoneNumber);
                  }
                } else {
                  login(phoneNumber, password);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                showSignUp ? (isOtpSent ? 'Verify OTP' : 'Send OTP') : 'Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  showSignUp = !showSignUp;
                  isOtpSent = false;
                });
              },
              child: Text(
                showSignUp
                    ? 'Already have an account? Sign In here'
                    : 'Don’t have an account? Sign Up here',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
          // Store the JWT Token and other global data
          GlobalData.jwtToken = data['jwt_token'] ?? '';
          GlobalData.goToDashboard = data['go_to_dashboard'] ?? false;
          GlobalData.model = data['model'] ?? '';

          // Update the Teacher instance in GlobalData
          if (data['teacher'] != null) {
            GlobalData.teacher.updateTeacher(data['teacher']);
          }

          // Print stored data
          print("Stored Global Data:");
          print("JWT Token: ${GlobalData.jwtToken}");
          print("Go To Dashboard: ${GlobalData.goToDashboard}");
          print("Model: ${GlobalData.model}");
          print("Teacher Details:");
          print("Zoho ID: ${GlobalData.teacher.zohoId}");
          print("ID: ${GlobalData.teacher.id}");
          print("Name: ${GlobalData.teacher.name}");
          print("Phone Contact: ${GlobalData.teacher.phoneContact}");
          print("Secondary Contact: ${GlobalData.teacher.secondaryContact}");
          print("Email: ${GlobalData.teacher.email}");
          print("Created At: ${GlobalData.teacher.createdAt}");
          print("State: ${GlobalData.teacher.state}");
          print("Area: ${GlobalData.teacher.area}");
          print("Pincode: ${GlobalData.teacher.pincode}");
          print("Location: ${GlobalData.teacher.location}");
          print("Subscription Validity: ${GlobalData.teacher.subscriptionValidity}");
          print("Password Last Modified: ${GlobalData.teacher.passwordLastModified}");
          print("Profile Pic: ${GlobalData.teacher.profilePic}");
          print("Introduction: ${GlobalData.teacher.introduction}");
          print("Teaching Description: ${GlobalData.teacher.teachingDesc}");
          print("Video URL: ${GlobalData.teacher.videoUrl}");
          print("Lesson Price: ${GlobalData.teacher.lessonPrice}");
          print("Current Status: ${GlobalData.teacher.currentStatus}");
          print("Teaching Mode: ${GlobalData.teacher.teachingMode}");
          print("Referral: ${GlobalData.teacher.referral}");
          print("Basic Done: ${GlobalData.teacher.basicDone}");
          print("Location Done: ${GlobalData.teacher.locationDone}");
          print("Later Onboarding Done: ${GlobalData.teacher.laterOnboardingDone}");

          // Check if location is available, if not, navigate to LocationPickerWidget
          if (GlobalData.teacher.location == null || GlobalData.teacher.location.isEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LocationPickerWidget(
                  isTeacher: true,
                ),
              ),
            );
          } else {
            // Navigate to the appropriate screen
            if (GlobalData.goToDashboard) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashboardWidget()),
              );
            } else {
              showErrorDialog("You need to complete onboarding.");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EducationDetails()),
              );
            }
          }
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

}




