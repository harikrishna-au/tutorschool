import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:tutorschool/widget/registration/subscriptions_widget.dart';

class LocationPickerWidget extends StatefulWidget {
  final bool isTeacher;

  const LocationPickerWidget({Key? key, required this.isTeacher}) : super(key: key);

  @override
  _LocationPickerWidgetState createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  LatLng _currentLocation = LatLng(22.5726, 88.3639);

  final _locationFormKey = GlobalKey<FormState>();
  final MapController _mapController = MapController();

  @override
  void dispose() {
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _saveLocation() {
    if (_locationFormKey.currentState!.validate()) {
      Map<String, dynamic> locationData = {
        'country': countryController.text,
        'state': stateController.text,
        'city': cityController.text,
        'pincode': pincodeController.text,
        'address': addressController.text,
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isTeacher ? 'Tutor Location' : 'Parent Location'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _locationFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLocationInputs(),
                    SizedBox(height: 20),
                    _buildMapSection(),
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
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the SubscriptionPage when the button is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SubscriptionPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInputs() {
    return Column(
      children: [
        TextFormField(
          controller: countryController,
          decoration: InputDecoration(
            labelText: 'Country',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.public),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter country';
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
          controller: cityController,
          decoration: InputDecoration(
            labelText: 'City',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter city';
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
        SizedBox(height: 10),
        TextFormField(
          controller: addressController,
          decoration: InputDecoration(
            labelText: 'Full Address',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.home),
          ),
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter full address';
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentLocation,
            initialZoom: 10.0,
            onTap: (tapPosition, point) {
              setState(() {
                _currentLocation = point;
              });
              _mapController.move(point, 10.0);
            },
          ),
          children: [
            TileLayer(
              tileProvider: CancellableNetworkTileProvider(),
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _currentLocation,
                  width: 10.0,
                  height: 10.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.move(_currentLocation, 10.0);
    });
  }
}
