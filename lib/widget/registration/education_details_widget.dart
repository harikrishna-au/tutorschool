import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../global_state.dart';
import '../../utils/appconfig.dart';
import 'add_location_widget.dart';

enum CurrentStatus { jobless, student, teacher, professional, housewife }
enum TeachingMode { online, offline, both }

class EducationDetails extends StatefulWidget {
  const EducationDetails({super.key});

  @override
  State<EducationDetails> createState() => _EducationDetailsState();
}

class _EducationDetailsState extends State<EducationDetails> {
  String selectedTeachingMode = 'Online';
  String? selectedDegree;
  String? selectedUniversity;
  String? selectedCurrentStatus;
  String? selectedReferral;
  final _universityController = TextEditingController();

  @override
  void dispose() {
    _universityController.dispose();
    super.dispose();
  }

  Future<void> sendDataToAPI() async {
    if (selectedDegree == null ||
        selectedUniversity == null ||
        selectedCurrentStatus == null ||
        selectedTeachingMode.isEmpty ||
        selectedReferral == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    String jwtToken = GlobalData.jwtToken;

    final data = {
      'degree': selectedDegree,
      'university': selectedUniversity?.trim(),
      'current_status': currentStatusFromString(selectedCurrentStatus),
      'teaching_mode': teachingModeFromString(selectedTeachingMode),
      'referral': selectedReferral,
    };

    print("Sending data: $data");

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.basic),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LocationPickerWidget(
              isTeacher: true,
            ),
          ),
        );
      } else {
        print('Failed to send data: ${response.statusCode}, ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send data: ${response.statusCode} - ${response.body}')), // Include response body
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  String currentStatusFromString(String? status) {
    switch (status?.toUpperCase()) {
      case 'JOB ASPIRANT':
        return 'JOBLESS';
      case 'COLLEGE STUDENT':
        return 'STUDENT';
      case 'FULL TIME TEACHER':
        return 'TEACHER';
      case 'WORKING PROFESSIONAL':
        return 'PROFESSIONAL';
      case 'EDUCATED HOUSEWIFE':
        return 'HOUSEWIFE';
      default:
        return 'JOBLESS'; // Default case
    }
  }

  String teachingModeFromString(String mode) {
    switch (mode.toUpperCase()) {
      case 'ONLINE':
        return 'ONLINE';
      case 'OFFLINE':
        return 'OFFLINE';
      case 'BOTH':
        return 'BOTH';
      default:
        return 'ONLINE'; // Default case
    }
  }

  Widget _buildDropdown({
    required String labelText,
    required String? value,
    required ValueChanged<String?> onChanged,
    required List<String> items,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        value: value,
        onChanged: onChanged,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTeachingMode() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              'Teaching Mode *',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            ),
          ),
          Row(
            children: [
              _buildRadio('Online', selectedTeachingMode),
              _buildRadio('Offline', selectedTeachingMode),
              _buildRadio('Both', selectedTeachingMode),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(String title, String groupValue) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(title),
        value: title,
        groupValue: groupValue,
        onChanged: (value) {
          setState(() {
            selectedTeachingMode = value!;
          });
        },
      ),
    );
  }

  Widget _buildReferralDropdown() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Referral (optional)',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        value: selectedReferral,
        onChanged: (value) {
          setState(() {
            selectedReferral = value;
          });
        },
        items: const [
          'Social Media',
          'Friend/Family',
          'Search Engine',
          'Advertisement',
          'Other',
        ]
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education Details'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              _buildDropdown(
                labelText: 'Highest Qualification *',
                value: selectedDegree,
                onChanged: (value) => setState(() => selectedDegree = value),
                items: const [
                  '12th or Equivalent',
                  'B.A',
                  'B.Com',
                  'B.Sc',
                  'BCA',
                  'B.Ed',
                  'B.Tech',
                  'M.A',
                  'M.Com',
                  'MCA',
                  'Others',
                ],
              ),
              const SizedBox(height: 16.0),
              _buildTextField(
                labelText: 'University *',
                controller: _universityController,
                onChanged: (value) => selectedUniversity = value,
              ),
              const SizedBox(height: 16.0),
              _buildDropdown(
                labelText: 'Current Status *',
                value: selectedCurrentStatus,
                onChanged: (value) => setState(() => selectedCurrentStatus = value),
                items: const [
                  'College Student',
                  'Job Aspirant',
                  'Full time Teacher',
                  'Working Professional',
                  'Educated Housewife',
                ],
              ),
              const SizedBox(height: 16.0),
              _buildReferralDropdown(),
              const SizedBox(height: 16.0),
              _buildTeachingMode(),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: sendDataToAPI,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
