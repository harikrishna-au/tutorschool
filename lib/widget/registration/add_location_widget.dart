  import 'dart:js_interop';
  import 'package:tutorschool/global_state.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_map/flutter_map.dart';
  import 'package:latlong2/latlong.dart'; // Import LatLng
  import 'package:geocoding/geocoding.dart';
  import 'dart:convert';
  import 'package:http/http.dart' as http;


  import '../../utils/appconfig.dart';
import '../home_page_widget.dart';

  class LocationPickerWidget extends StatefulWidget {
    final bool isTeacher;

    const LocationPickerWidget({Key? key, required this.isTeacher}) : super(key: key);

    @override
    _LocationPickerWidgetState createState() => _LocationPickerWidgetState();
  }

  class _LocationPickerWidgetState extends State<LocationPickerWidget> {
    final TextEditingController areaController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController pincodeController = TextEditingController();

    LatLng _currentLocation = LatLng(22.5726, 88.3639); // Default location (Kolkata)
    double _currentZoom = 10.0; // Default zoom level

    @override
    void dispose() {
      areaController.dispose();
      stateController.dispose();
      pincodeController.dispose();
      super.dispose();
    }

    void _saveLocation() async {
      if (areaController.text.isEmpty ||
          stateController.text.isEmpty ||
          pincodeController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all the fields.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Construct the API payload
      Map<String, dynamic> locationData = {
        'latitude': _currentLocation.latitude.toString(),
        'longitude': _currentLocation.longitude.toString(),
        'area': areaController.text,
        'state': stateController.text,
        'pincode': pincodeController.text,
      };

      // JWT Token (replace with the actual token from authentication)
      String jwtToken = GlobalData.jwtToken;

      // API URL

      try {
        // Make POST request
        final response = await http.post(
          Uri.parse(ApiEndpoints.location),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwtToken',
          },
          body: jsonEncode(locationData),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location Saved'),
              backgroundColor: Colors.green,
            ),
          );
          print('API Response: ${response.body}');

          // Navigate to Dashboard after successful location save
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardWidget()), // Replace DashboardWidget with your actual dashboard widget
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to send data. Error: ${response.statusCode}'),
              backgroundColor: Colors.red,
            ),
          );
          print('Error: ${response.statusCode} - ${response.body}');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
        print('Exception: $e');
      }
    }


    Future<void> _zoomToArea(String area) async {
      try {
        List<Location> locations = await locationFromAddress(area);
        if (locations.isNotEmpty) {
          final targetLocation = locations.first;
          setState(() {
            _currentLocation = LatLng(targetLocation.latitude, targetLocation.longitude);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to locate the area. Please check the name.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.isTeacher ? 'Tutor Location' : 'Parent Location'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLocationInputs(),
                const SizedBox(height: 20),
                _buildMapSection(),
                const SizedBox(height: 10),
                _buildZoomControls(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Save Location',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildLocationInputs() {
      return Column(
        children: [
          TextFormField(
            controller: areaController,
            decoration: const InputDecoration(
              labelText: 'Area',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
            onFieldSubmitted: (value) {
              _zoomToArea(value);
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: stateController,
            decoration: const InputDecoration(
              labelText: 'State',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_city),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: pincodeController,
            decoration: const InputDecoration(
              labelText: 'Pincode',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.pin_drop),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      );
    }

    Widget _buildMapSection() {
      return Container(
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: _currentLocation,
            initialZoom: 10.0,
            onTap: (tapPosition, latlng) {
              setState(() {
                _currentLocation = latlng;
              });
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _currentLocation,
                  width: 40.0,
                  height: 40.0,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildZoomControls() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentZoom = (_currentZoom + 1).clamp(1.0, 18.0);
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            child: const Text(
              'Zoom In',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentZoom = (_currentZoom - 1).clamp(1.0, 18.0);
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            child: const Text(
              'Zoom Out',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    }
  }

