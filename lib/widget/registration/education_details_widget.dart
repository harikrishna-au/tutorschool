import 'package:flutter/material.dart';
import 'add_location_widget.dart';

void openEducationDetails(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EducationDetails()),
  );
}

class EducationDetails extends StatefulWidget {
  @override
  _EducationDetailsState createState() => _EducationDetailsState();
}

class _EducationDetailsState extends State<EducationDetails> {
  String? selectedTeachingMode = 'Online'; // State for Teaching Mode radio buttons

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
                  DropdownMenuItem(value: '12th or Equivalent', child: Text('12th or Equivalent')),
                  DropdownMenuItem(value: 'B.A', child: Text('B.A')),
                  DropdownMenuItem(value: 'B.Com', child: Text('B.Com')),
                  DropdownMenuItem(value: 'B.Sc', child: Text('B.Sc')),
                  DropdownMenuItem(value: 'BCA', child: Text('BCA')),
                  DropdownMenuItem(value: 'B.Ed', child: Text('B.Ed')),
                  DropdownMenuItem(value: 'B.Tech', child: Text('B.Tech')),
                  DropdownMenuItem(value: 'M.A', child: Text('M.A')),
                  DropdownMenuItem(value: 'M.Com', child: Text('M.Com')),
                  DropdownMenuItem(value: 'MCA', child: Text('MCA')),
                  DropdownMenuItem(value: 'Others', child: Text('Others')),
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
                  DropdownMenuItem(value: 'College Student', child: Text('College Student')),
                  DropdownMenuItem(value: 'Job Aspirant', child: Text('Job Aspirant')),
                  DropdownMenuItem(value: 'Full time Teacher', child: Text('Full time Teacher')),
                  DropdownMenuItem(value: 'Working Professional', child: Text('Working Professional')),
                  DropdownMenuItem(value: 'Educated Housewife', child: Text('Educated Housewife')),
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
                      groupValue: selectedTeachingMode,
                      onChanged: (value) {
                        setState(() {
                          selectedTeachingMode = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Offline'),
                      value: 'Offline',
                      groupValue: selectedTeachingMode,
                      onChanged: (value) {
                        setState(() {
                          selectedTeachingMode = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Both'),
                      value: 'Both',
                      groupValue: selectedTeachingMode,
                      onChanged: (value) {
                        setState(() {
                          selectedTeachingMode = value;
                        });
                      },
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
                  DropdownMenuItem(value: 'Friend/Family', child: Text('Friend/Family')),
                  DropdownMenuItem(value: 'Search Engine', child: Text('Search Engine')),
                  DropdownMenuItem(value: 'Advertisement', child: Text('Advertisement')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
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
