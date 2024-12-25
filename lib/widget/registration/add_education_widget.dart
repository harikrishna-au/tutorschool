import 'package:flutter/material.dart';
import 'add_description_widget.dart';

class EducationRegistrationWidget extends StatefulWidget {
  @override
  _EducationRegistrationWidgetState createState() =>
      _EducationRegistrationWidgetState();
}

class _EducationRegistrationWidgetState
    extends State<EducationRegistrationWidget> {
  final TextEditingController universityController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  String? selectedDegreeType;

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
          child: _buildEducationForm(context),
        ),
      ),
    );
  }

  Widget _buildEducationForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Education Details',
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
                  controller: universityController,
                  decoration: InputDecoration(
                    labelText: 'University*',
                    hintText: 'E.g. Mount Royal University',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: degreeController,
                  decoration: InputDecoration(
                    labelText: 'Degree*',
                    hintText: 'E.g. Bachelor\'s degree',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Degree Type*',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedDegreeType,
                  items: [
                    'Associate\'s Degree',
                    'Bachelor\'s Degree',
                    'Master\'s Degree',
                    'Doctorate'
                  ]
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDegreeType = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: specializationController,
                  decoration: InputDecoration(
                    labelText: 'Specialization*',
                    hintText: 'E.g. Teaching English as a Foreign Language',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: fromController,
                        decoration: InputDecoration(
                          labelText: 'From*',
                          hintText: 'Start Year',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: toController,
                        decoration: InputDecoration(
                          labelText: 'To*',
                          hintText: 'End Year',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDescriptionWidget(),
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
