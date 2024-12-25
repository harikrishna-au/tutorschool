import 'package:flutter/material.dart';

class ParentSignUpWidget extends StatefulWidget {
  @override
  _ParentSignUpWidgetState createState() => _ParentSignUpWidgetState();
}

class _ParentSignUpWidgetState extends State<ParentSignUpWidget> {
  String mobileNumber = '';
  String otp = '';
  String enteredOtp = '';
  bool isOtpSent = false;
  String parentName = '';
  String childName = '';

  // Function to send OTP (mock OTP generation)
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('OTP Verified Successfully'),
      ));
      // Proceed to registration completion or main page
    } else {
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
          'Parent Sign Up - TutorSchool',
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
                'Sign Up as a Parent',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              // Parent Name input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Parent Name',
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  parentName = value;
                },
              ),
              SizedBox(height: 20),
              // Child Name input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Child\'s Name',
                  hintText: 'Enter your child\'s name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  childName = value;
                },
              ),
              SizedBox(height: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}
