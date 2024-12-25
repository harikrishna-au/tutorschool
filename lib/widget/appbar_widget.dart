import 'package:flutter/material.dart';
import 'notification_space.dart'; // Import the notification space widget

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('TutorSchool'), // App bar title
      backgroundColor: Colors.green, // AppBar background color
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.white), // Bell icon
          onPressed: () {
            // Navigate to the NotificationSpace when the bell icon is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationSpace()),
            );
          },
        ),
      ],
    );
  }
}
