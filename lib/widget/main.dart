import 'package:flutter/material.dart';
import 'authentication_choice_widget.dart';
import 'home_page_widget.dart';
import 'login_widget.dart';
import 'registration/signup_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationWidget(),
    );
  }
}

class AuthenticationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulating a function to check if the user is authenticated
    bool isAuthenticated =
        false; // Set this according to your authentication logic

    if (isAuthenticated) {
      return HomePageWidget();
    } else {
      return AuthenticationChoice();
    }
  }
}
