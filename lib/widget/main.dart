import 'package:flutter/material.dart';
import 'authentication_choice_widget.dart';
import 'home_page_widget.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TutorSchool',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AuthenticationWidget(),
    );
  }
}

class AuthenticationWidget extends StatelessWidget {
  // Simulated authentication logic
  bool isAuthenticated() {
    // Replace this with your actual authentication logic
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Check authentication state and navigate accordingly
    return isAuthenticated() ? DashboardWidget() : AuthenticationChoice();
  }
}
