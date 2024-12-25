import 'package:flutter/material.dart';
import 'appbar_widget.dart';
// Import the custom app bar

class HomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Using the reusable custom app bar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome back, User!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the user's dashboard or profile
                print('Navigating to user dashboard');
              },
              child: Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
