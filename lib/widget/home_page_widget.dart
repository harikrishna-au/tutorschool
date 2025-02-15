import 'package:flutter/material.dart';
import 'package:tutorschool/widget/registration/subscriptions_widget.dart';
import '../global_state.dart';
import 'authentication_choice_widget.dart'; // Import the AuthenticationChoiceWidget

class DashboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the teacher data from the global instance
    final teacher = GlobalData.teacher;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tutor School',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade300,
        elevation: 10,
        shadowColor: Colors.green.withOpacity(0.5),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notifications
            },
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              // Handle subscription
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SubscriptionPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 5,
            ),
            child: Text(
              'Get Subscription',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              // Handle logout
              handleLogout(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 5,
            ),
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Teacher Profile',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade800,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: teacher.profilePic.isNotEmpty
                                                  ? NetworkImage(teacher.profilePic)
                                                  : null,
                                              child: teacher.profilePic.isEmpty
                                                  ? Text(
                                                teacher.name.isNotEmpty
                                                    ? teacher.name[0]
                                                    : 'T',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              )
                                                  : null,
                                              backgroundColor: Colors.green.shade300,
                                            ),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    teacher.name.isNotEmpty
                                                        ? teacher.name
                                                        : 'No Name',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.green.shade800,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    teacher.email.isNotEmpty
                                                        ? teacher.email
                                                        : 'No Email',
                                                    style: TextStyle(
                                                      color: Colors.grey.shade700,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    teacher.phoneContact.isNotEmpty
                                                        ? teacher.phoneContact
                                                        : 'No Contact',
                                                    style: TextStyle(
                                                      color: Colors.grey.shade700,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Subscription',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade800,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          teacher.subscriptionValidity.isNotEmpty
                                              ? 'Valid until: ${teacher.subscriptionValidity}'
                                              : 'No Subscription',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ElevatedButton(
                                          onPressed: null,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                            elevation: 5,
                                          ),
                                          child: Text(
                                            'Not Active',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Flexible(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Icon(Icons.lock, size: 40, color: Colors.grey.shade600),
                                        SizedBox(height: 8),
                                        Text(
                                          'Session History is Locked',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Certifications',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade800,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          'Professional certifications and achievements',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '*No Certificates*',
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void handleLogout(BuildContext context) {
    // Clear global state
    GlobalData.jwtToken = '';
    GlobalData.teacher = Teacher();  // Reset teacher data by creating a new Teacher object
    GlobalData.accessHash = '';
    GlobalData.goToDashboard = false;

    // Navigate back to AuthenticationChoiceWidget
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthenticationChoice()),
    );
  }
}