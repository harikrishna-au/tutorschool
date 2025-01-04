import 'package:flutter/material.dart';
import '../global_state.dart';

class DashboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.green.shade600,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Handle log out functionality here
              logOut(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, ${GlobalData.teacher.name}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            SizedBox(height: 16),
            Text("Email: ${GlobalData.teacher.email}"),
            Text("Phone: ${GlobalData.teacher.phoneContact}"),
            Text("Teaching Mode: ${GlobalData.teacher.teachingMode}"),
            Text("Lesson Price: ${GlobalData.teacher.lessonPrice}"),
            Text("Profile Created At: ${GlobalData.teacher.createdAt}"),
            SizedBox(height: 16),
            Text("Profile Information"),
            SizedBox(height: 8),
            Text("Referral: ${GlobalData.teacher.referral ?? 'Not available'}"),
            Text("State: ${GlobalData.teacher.state ?? 'Not available'}"),
            Text("Location: ${GlobalData.teacher.location ?? 'Not available'}"),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate to Profile Settings or any other relevant screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileSettingsWidget(),
                  ),
                );
              },
              child: Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Handle log out functionality
  void logOut(BuildContext context) {
    // Clear global data or handle any cleanup
    GlobalData.jwtToken = '';
    GlobalData.goToDashboard = false;
    GlobalData.model = '';
    GlobalData.teacher = Teacher(); // Reset teacher data

    // Optionally navigate to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),  // Replace with your actual login screen widget
      ),
    );
  }
}

class ProfileSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Settings"),
        backgroundColor: Colors.green.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit your profile settings here", style: TextStyle(fontSize: 18)),
            // Add form fields for profile editing
            // E.g. TextFormField for editing the name, email, etc.
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Text("Login screen will be here"),
      ),
    );
  }
}
