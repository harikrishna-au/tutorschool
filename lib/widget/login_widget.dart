import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tutorschool/widget/registration/signup_widget.dart';
import 'home_page_widget.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool isOtpRequested = false; // Tracks if OTP has been requested

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Log in to your account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              // Card container for login form
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
                        controller: mobileController,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: 'Enter your mobile number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 20),
                      // Request OTP button
                      ElevatedButton(
                        onPressed: () async {
                          final phone = mobileController.text.trim();
                          if (phone.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Please enter your phone number')),
                            );
                            return;
                          }
                          final isOtpSent = await requestOtp(phone);
                          if (isOtpSent) {
                            setState(() {
                              isOtpRequested = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('OTP sent successfully')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to send OTP')),
                            );
                          }
                        },
                        child: Text('Request OTP'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                      if (isOtpRequested) ...[
                        SizedBox(height: 20),
                        // OTP input field
                        TextField(
                          controller: otpController,
                          decoration: InputDecoration(
                            labelText: 'Enter OTP',
                            hintText: 'Enter the OTP sent to your phone',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        // Verify OTP button
                        ElevatedButton(
                          onPressed: () async {
                            final phone = mobileController.text.trim();
                            final otp = otpController.text.trim();

                            if (phone.isEmpty || otp.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Please enter all fields')),
                              );
                              return;
                            }

                            final isVerified = await verifyOtp(phone, otp);
                            if (isVerified) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Phone verified successfully')),
                              );
                              // Navigate to the home page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageWidget()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Invalid OTP')),
                              );
                            }
                          },
                          child: Text('Verify OTP'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: Size(double.infinity, 50),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Sign Up Button
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpWidget()),
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign Up',
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

Future<bool> requestOtp(String phone) async {
  final url = Uri.parse('https://backend-oy4r.onrender.com/auth/teacher/start');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(
          'OTP sent successfully: ${data["otp"]}'); // Remove this in production
      return true;
    }
  } catch (e) {
    print('Error sending OTP: $e');
  }
  return false;
}

Future<bool> verifyOtp(String phone, String otp) async {
  final url =
      Uri.parse('https://backend-oy4r.onrender.com/auth/teacher/verify');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Phone verified successfully: ${data["access_hash"]}');
      return true;
    }
  } catch (e) {
    print('Error verifying OTP: $e');
  }
  return false;
}
