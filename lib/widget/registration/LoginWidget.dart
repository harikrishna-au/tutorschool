import 'package:flutter/material.dart';

import 'ParentSignUpWidget.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String mobileNumber = '';
  String otp = '';
  String enteredOtp = '';
  bool isOtpSent = false;

  // Function to send OTP (for demo purposes, using random OTP)
  void sendOtp() {
    if (mobileNumber.isNotEmpty) {
      otp = (100000 + (999999 - 100000) * (DateTime.now().microsecond % 1000))
          .toString();
      print('Generated OTP: $otp');
      setState(() {
        isOtpSent = true;
      });
    } else {
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
      // Proceed to next screen or home page
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
        backgroundColor: Colors.green,
        title: Text(
          'Login - TutorSchool',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back to TutorSchool!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              // Mobile number input
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
              // OTP input (visible after OTP is sent)
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
              // Send OTP or Validate OTP button
              ElevatedButton(
                onPressed: isOtpSent ? validateOtp : sendOtp,
                child: Text(isOtpSent ? 'Verify OTP' : 'Send OTP'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 10),
              // Sign up button for new users
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ParentSignUpWidget()),
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign Up here',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
