import 'package:flutter/material.dart';
import 'widget/authentication_choice_widget.dart';
import 'widget/home_page_widget.dart';
import 'dart:js' as js;
import 'dart:html' as html;

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


void handleGoogleSignIn() {
  html.window.onMessage.listen((event) {
    var data = event.data;
    if (data != null && data['credential'] != null) {
      String idToken = data['credential'];
      print("Google ID Token: $idToken");
      // Send this token to Firebase for authentication
    }
  });
}

bool isSignInInProgress = false;

void showGoogleSignIn() async {
  if (isSignInInProgress) {
    print("Sign-in already in progress, please wait.");
    return;
  }

  isSignInInProgress = true;

  try {
    // Call Google Sign-In logic here
    js.context.callMethod('eval', ["""
      google.accounts.id.initialize({
        client_id: '923494592455-dk0uefivffrfs5vmq2nopi4a4kr84hoj.apps.googleusercontent.com',
        callback: function(response) { 
          console.log(response); 
        }
      });
      google.accounts.id.prompt();
    """]);
  } catch (e) {
    print("Error during Google Sign-In: $e");
  } finally {
    // Reset the flag after the process is finished
    isSignInInProgress = false;
  }
}

