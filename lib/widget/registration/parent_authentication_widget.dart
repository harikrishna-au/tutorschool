/*
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'home_page_widget.dart';
import 'login_widget.dart';
import 'registration/signup_widget.dart';
import 'registration/parent_signup_widget.dart'; // Import the Parent Sign Up page
import 'dart:math'; // For OTP generation

class AuthenticationChoice extends StatefulWidget {
  @override
  _AuthenticationChoiceState createState() => _AuthenticationChoiceState();
}

class _AuthenticationChoiceState extends State<AuthenticationChoice> {
  bool isTeacher = true; // true: Teacher, false: Parent
  String mobileNumber = '';
  String otp = '';
  String enteredOtp = '';
  bool isOtpSent = false;

  // Function to generate and send OTP (Mock Implementation)
  void sendOtp() {
    if (mobileNumber.isNotEmpty) {
      // Generate a 6-digit OTP
      otp = (Random().nextInt(900000) + 100000).toString();
      print('Generated OTP: $otp');

      // Simulate sending OTP via SMS (you can use Firebase or any SMS service here)
      setState(() {
        isOtpSent = true;
      });

      // In a real app, you would call a backend service here to send the OTP.
    } else {
      // Show an error if the mobile number is not provided
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid mobile number'),
      ));
    }
  }

  // Function to validate OTP
  void validateOtp() {
    if (enteredOtp == otp) {
      // OTP is correct
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('OTP Verified Successfully'),
      ));
      // Proceed with the next steps (like navigating to the main screen)
    } else {
      // OTP is incorrect
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid OTP. Please try again.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Green background
        title: Text(
          'TutorSchool',
          style: TextStyle(color: Colors.white), // White text
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome message
              Text(
                'Welcome to TutorSchool!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              // Sliding button to toggle between Teacher and Parent
              SliderButton(
                action: () async {
                  setState(() {
                    isTeacher = !isTeacher;
                  });
                  return Future.value(true); // Indicate action successful
                },
                label: Text(
                  isTeacher ? 'Teacher' : 'Parent',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                icon: Icon(
                  isTeacher ? Icons.school : Icons.home,
                  color: Colors.white,
                  size: 40.0,
                ),
                width: 250,
                height: 60,
                buttonColor: Colors.green,
                backgroundColor: Colors.grey[300]!,
                boxShadow: BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ),
              SizedBox(height: 30),
              // Card container for number input and OTP
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Mobile Number input
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: 'Enter your mobile number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          mobileNumber = value;
                        },
                      ),
                      SizedBox(height: 20),
                      // OTP input
                      if (isOtpSent)
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'OTP',
                            hintText: 'Enter OTP received',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            enteredOtp = value;
                          },
                        ),
                      SizedBox(height: 20),
                      // Send OTP button
                      ElevatedButton(
                        onPressed: isOtpSent ? validateOtp : sendOtp,
                        child: Text(isOtpSent ? 'Verify OTP' : 'Send OTP'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Sign In button for existing users
                      TextButton(
                        onPressed: () {
                          // Navigate to Sign In page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginWidget()),
                          );
                        },
                        child: Text(
                          'Already have an account? Sign In here',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Dynamic Sign Up button for Teacher or Parent
              TextButton(
                onPressed: () {
                  if (isTeacher) {
                    // Navigate to Teacher Sign Up page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpWidget()),
                    );
                  } else {
                    // Navigate to Parent Sign Up page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParentSignUpWidget()),
                    );
                  }
                },
                child: Text(
                  isTeacher ? 'Teacher Sign Up' : 'Parent Sign Up',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
