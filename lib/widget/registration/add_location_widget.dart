import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

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

  late GoogleMapController _mapController;
  LatLng _currentLocation = LatLng(22.5726, 88.3639);
  double _currentZoom = 10.0; // Track the current zoom level

  @override
  void dispose() {
    areaController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  void _saveLocation() {
    Map<String, dynamic> locationData = {
      'area': areaController.text,
      'state': stateController.text,
      'pincode': pincodeController.text,
      'latitude': _currentLocation.latitude,
      'longitude': _currentLocation.longitude,
    };

    print('Location Data: $locationData');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Location saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _zoomToArea(String area) async {
    try {
      List<Location> locations = await locationFromAddress(area);
      if (locations.isNotEmpty) {
        final targetLocation = locations.first;
        setState(() {
          _currentLocation = LatLng(targetLocation.latitude, targetLocation.longitude);
        });
        _mapController.animateCamera(CameraUpdate.newLatLng(_currentLocation));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to locate the area. Please check the name.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _zoomIn() {
    setState(() {
      _currentZoom += 1;
    });
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: _currentLocation, zoom: _currentZoom),
    ));
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(1.0, 18.0); // Ensure zoom stays within valid range
    });
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: _currentLocation, zoom: _currentZoom),
    ));
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
              SizedBox(height: 20),
              _buildMapSection(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _zoomIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    child: Text(
                      'Zoom In',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _zoomOut,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    child: Text(
                      'Zoom Out',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
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
          decoration: InputDecoration(
            labelText: 'Area',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
          ),
          onFieldSubmitted: (value) {
            _zoomToArea(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter area';
            }
            return null;
          },
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: stateController,
          decoration: InputDecoration(
            labelText: 'State',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_city),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter state';
            }
            return null;
          },
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: pincodeController,
          decoration: InputDecoration(
            labelText: 'Pincode',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.pin_drop),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter pincode';
            }
            return null;
          },
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
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation,
          zoom: _currentZoom,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        onTap: (LatLng point) {
          setState(() {
            _currentLocation = point;
          });
          _mapController.animateCamera(CameraUpdate.newLatLng(_currentLocation));
        },
        markers: {
          Marker(
            markerId: MarkerId('currentLocation'),
            position: _currentLocation,
            infoWindow: InfoWindow(title: 'Current Location'),
          ),
        },
      ),
    );
  }
}
