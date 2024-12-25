import 'package:flutter/material.dart';

class NotificationSpace extends StatefulWidget {
  @override
  _NotificationSpaceState createState() => _NotificationSpaceState();
}

class _NotificationSpaceState extends State<NotificationSpace> {
  // List to store notifications
  List<String> notifications = [
    'New course available on Flutter.',
    'Reminder: Meeting with the tutor at 3 PM today.',
    'Your profile has been updated successfully.',
    'A new course has been added to your dashboard.',
  ];

  // Function to add a new notification
  void addNotification() {
    setState(() {
      notifications.add('New notification at ${DateTime.now()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            addNotification, // Add a notification when the button is clicked
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
