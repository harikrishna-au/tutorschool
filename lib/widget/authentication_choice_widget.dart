import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';
import 'authentication_choice_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool isLoggedIn = await checkLoginStatus();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false; // Check if logged in
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? HomePage() : AuthenticationChoice(), // Redirect based on login status
    );
  }
}

class AuthenticationChoice extends StatefulWidget {
  @override
  _AuthenticationChoiceState createState() => _AuthenticationChoiceState();
}

class _AuthenticationChoiceState extends State<AuthenticationChoice> {
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
            SizedBox(height: 20),
            Text(
              'OR',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showGoogleSignIn();
              },
              child: Text("Sign in with Google"),
            )

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
  bool isPhoneNumberValid = true;
  bool isPasswordValid = true;
  bool isOtpValid = true;
  bool showError = false;

  String phoneNumber = '';
  String otp = '';
  String password = '';
  void validateInput() {
    setState(() {
      isPhoneNumberValid = phoneNumber.isNotEmpty && phoneNumber.length == 10;
      isPasswordValid = password.isNotEmpty && password.length >= 6;
      isOtpValid = otp.isNotEmpty && otp.length == 6;

      // Show error if phone number is invalid or, in case of login, if password is invalid
      showError = !isPhoneNumberValid || (!showSignUp && !isPasswordValid);
    });

    if (showError) {
      // If there is an error, highlight the invalid fields
      return;
    }

    if (showSignUp) {
      // Sign-up flow
      if (!isOtpSent) {
        // If OTP is not sent, send it first
        sendOtp(phoneNumber, context); // Imported function
        setState(() {
          isOtpSent = true; // Set OTP sent status to true
        });
      } else if (isOtpValid) {
        // If OTP is already sent and valid, verify it
        verifyOtp(phoneNumber, otp, context); // Imported function
      } else {
        // Show an error for invalid OTP
        setState(() {
          showError = true;
        });
      }
    } else {
      // Login flow
      login(phoneNumber, password, context); // Imported function
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 6),
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
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.green.shade700,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) => phoneNumber = value,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone, color: Colors.green),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Enter your phone number',
              hintStyle: TextStyle(color: Colors.grey.shade500),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: showError && !isPhoneNumberValid ? Colors.red : Colors.green,
                ),
              ),
            ),
          ),
          if (!showSignUp) ...[
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              onChanged: (value) => password = value,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter Password',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: showError && !isPasswordValid ? Colors.red : Colors.green,
                  ),
                ),
              ),
            ),
          ],
          if (isOtpSent && showSignUp) ...[
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => otp = value,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.security, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter OTP',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isOtpValid ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: validateInput,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                backgroundColor: Colors.green.shade700,
              ),
              child: Text(
                showSignUp ? (isOtpSent ? 'Verify OTP' : 'Send OTP') : 'Login',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (showError) ...[
            SizedBox(height: 16),
            Text(
              "Please check your inputs.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  showSignUp = !showSignUp;
                  isOtpSent = false;
                  showError = false; // Reset the error on toggle
                });
              },
              child: Text(
                showSignUp
                    ? 'Already have an account? Sign In here'
                    : 'Don’t have an account? Sign Up here',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
  class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout(context);  // Call logout when the user taps the logout button
            },
          )
        ],
      ),
      body: Center(
        child: Text('Welcome to the home page!'),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');  // Clear login state

    // Sign out from Google
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();

    // Navigate to AuthenticationChoice
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthenticationChoice()),
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: kIsWeb
      ? "923494592455-dk0uefivffrfs5vmq2nopi4a4kr84hoj.apps.googleusercontent.com"
      : null, // Web requires clientId, mobile uses default config
);

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
    await _googleSignIn.signInSilently(); // Use signInSilently() for web

    if (googleSignInAccount == null) {
      print("User is not signed in. Render button manually on web.");
      return;
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      // Save login status
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  } catch (error) {
    print("Error during Google Sign-In: $error");
  }
}