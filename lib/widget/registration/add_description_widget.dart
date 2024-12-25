import 'package:flutter/material.dart';
import 'add_video_widget.dart'; // Import the video upload widget

class AddDescriptionWidget extends StatefulWidget {
  @override
  _AddDescriptionWidgetState createState() => _AddDescriptionWidgetState();
}

class _AddDescriptionWidgetState extends State<AddDescriptionWidget> {
  final TextEditingController profileDescriptionController =
      TextEditingController();
  final TextEditingController teachingExperienceController =
      TextEditingController();

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildDescriptionForm(context),
        ),
      ),
    );
  }

  Widget _buildDescriptionForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Profile Description',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: profileDescriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Tell students about yourself',
                    hintText:
                        'Share your teaching experience and passion for education...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: teachingExperienceController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Teaching Experience',
                    hintText:
                        'Describe your teaching methodology, experience, and expertise...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddVideoWidget(), // Navigate to AddVideoWidget
                      ),
                    );
                  },
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
