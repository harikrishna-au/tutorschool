import 'package:flutter/material.dart';
import 'package:tutorschool/widget/registration/details_registration_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        backgroundColor: Colors.green, // Green background
        title: Text(
          'TutorSchool',
          style: TextStyle(color: Colors.white), // White text
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
              child: AuthenticationWidget(
                onTeacherSelected: () {
                  setState(() {
                    isTeacherSelected = true;
                  });
                },
                onParentSelected: () {
                  setState(() {
                    isTeacherSelected = false;
                  });
                },
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: isTeacherSelected ? TutorSignupWidget() : ParentSignupWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthenticationWidget extends StatefulWidget {
  final VoidCallback onTeacherSelected;
  final VoidCallback onParentSelected;

  AuthenticationWidget({
    required this.onTeacherSelected,
    required this.onParentSelected,
  });

  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  double _dragPosition = 0.0;
  bool _isTeacherSide = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Background container with gradient and labels
        Container(
          width: width,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade700, Colors.green.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade900.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
        // Text to indicate choice
        Text(
          _isTeacherSide ? "Teacher" : "Parent",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Draggable button
        Positioned(
          left: _dragPosition,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _dragPosition += details.delta.dx;
                _dragPosition = _dragPosition.clamp(0.0, width - 60);
              });
            },
            onPanEnd: (details) {
              if (_dragPosition <= (width - 60) / 2) {
                setState(() {
                  _dragPosition = 0.0; // Snap to Teacher side
                  _isTeacherSide = true;
                });
                widget.onTeacherSelected();
              } else {
                setState(() {
                  _dragPosition = width - 60; // Snap to Parent side
                  _isTeacherSide = false;
                });
                widget.onParentSelected();
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.blue.shade300,
                    blurRadius: 5,
                    offset: Offset(-2, -2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(
                _isTeacherSide ? Icons.school : Icons.family_restroom,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
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

  Future<void> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse('https://api.tutorschool.in/auth/teacher/verify'), // Replace with actual API URL
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'phone': phone}),
    );

    if (response.statusCode == 200) {
      setState(() {
        isOtpSent = true;
      });
      print("OTP Sent");
    } else {
      // Handle error, show error message to the user
      print("Failed to send OTP");
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    final response = await http.post(
      Uri.parse('https://api.tutorschool.in/auth/teacher/google'), // Replace with actual verify OTP URL
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'phone': phone, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      // Handle success, navigate to the next screen
      print("OTP Verified");
    } else {
      // Handle error, show error message to the user
      print("Failed to verify OTP");
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
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          if (isOtpSent) ...[
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => otp = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter OTP',
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ],
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (isOtpSent) {
                  verifyOtp(phoneNumber, otp);
                } else {
                  sendOtp(phoneNumber);
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
                isOtpSent ? 'Verify OTP' : 'Send OTP',
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
                  isOtpSent = false; // Reset OTP flow on mode switch
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
}

class ParentSignupWidget extends StatefulWidget {
  @override
  _ParentSignupWidgetState createState() => _ParentSignupWidgetState();
}

class _ParentSignupWidgetState extends State<ParentSignupWidget> {
  bool showSignUp = true;

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
        crossAxisAlignment: CrossAxisAlignment.center, // Center all content
        children: [
          Text(
            showSignUp ? 'Parent Signup' : 'Parent Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold, // Bold style for the title
              color: Colors.green.shade800,
            ),
          ),
          SizedBox(height: 24),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Enter your phone number',
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          if (!showSignUp) ...[
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter your password',
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ],
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (showSignUp) {
                  print("Parent OTP Sent");
                } else {
                  print("Parent Login Submitted");
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
                showSignUp ? 'Send OTP' : 'Sign In',
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
                });
              },
              child: Text(
                showSignUp
                    ? 'Already have an account? Sign In here'
                    : 'Don’t have an account? Sign Up here',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold, // Bold text for link
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



}
