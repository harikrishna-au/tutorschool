import 'package:flutter/material.dart';
import 'add_location_widget.dart';

void openEducationDetails(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EducationDetails()),
  );
}

class EducationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Education Details'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Highest Qualification
            Text(
              'Highest Qualification *',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem(value: 'Bachelors', child: Text('Bachelors')),
                  DropdownMenuItem(value: 'Masters', child: Text('Masters')),
                  DropdownMenuItem(value: 'PhD', child: Text('PhD')),
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Select your qualification',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // University
            Text(
              'University *',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your college name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Current Status
            Text(
              'Current Status*',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem(value: 'Student', child: Text('Student')),
                  DropdownMenuItem(value: 'Working', child: Text('Working')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Select your current status',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Teaching Mode
            Text(
              'Teaching Mode *',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Online'),
                      value: 'Online',
                      groupValue: 'teachingMode',
                      onChanged: (value) {},
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Offline'),
                      value: 'Offline',
                      groupValue: 'teachingMode',
                      onChanged: (value) {},
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Both'),
                      value: 'Both',
                      groupValue: 'teachingMode',
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // How did you hear about us?
            Text(
              'How did you hear about us? *',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem(value: 'Social Media', child: Text('Social Media')),
                  DropdownMenuItem(value: 'Friend', child: Text('Friend')),
                  DropdownMenuItem(value: 'Advertisement', child: Text('Advertisement')),
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Select source',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ),
            SizedBox(height: 24.0),

            // Next Button
            ElevatedButton(
              onPressed: () {
                // Navigate to Location Picker Widget
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationPickerWidget(
                      isTeacher: true, // Pass the required parameter
                    ),
                  ),
                );
              },
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
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
}
