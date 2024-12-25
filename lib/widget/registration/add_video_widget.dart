import 'package:flutter/material.dart';
import 'add_location_widget.dart'; // Adjust the import path if needed

class AddVideoWidget extends StatefulWidget {
  @override
  _AddVideoWidgetState createState() => _AddVideoWidgetState();
}

class _AddVideoWidgetState extends State<AddVideoWidget> {
  String videoFileName = 'No file chosen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Upload Your Video'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildAddVideoForm(context),
        ),
      ),
    );
  }

  Widget _buildAddVideoForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload Your Video',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Choose a professional video for your profile',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print('Upload Video clicked');
            },
            child: Text('Upload Video'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(double.infinity, 50),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: Text(videoFileName)),
              ElevatedButton(
                onPressed: () {
                  print('Choose File clicked');
                  setState(() {
                    videoFileName = 'ExampleVideo.mp4'; // Mock file selection
                  });
                },
                child: Text('Choose File'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Video requirements:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('✓ Maximum duration: 2 minutes'),
              Text('✓ Landscape orientation (16:9)'),
              Text('✓ HD quality (1080p minimum)'),
              Text('✓ No background music or filters'),
            ],
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              print('Skip for now clicked');
              Navigator.pop(context);
            },
            child: Text('Skip for Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              minimumSize: Size(double.infinity, 50),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print('Next clicked');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationPickerWidget(isTeacher: true), // Pass a valid boolean value
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
    );
  }
}
