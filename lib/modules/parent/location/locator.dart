import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // For geolocation
import 'package:geocoding/geocoding.dart'; // For geocoding the coordinates to location name

class MyMapPage extends StatefulWidget {
  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  String locationName = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Get the current location when the widget is created
  }

  // Function to get the current location of the user
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationName = 'Location services are disabled.';
      });
      return;
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationName = 'Location permissions are denied.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationName = 'Location permissions are permanently denied, we cannot request permissions.';
      });
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Get the location name using the coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      setState(() {
        locationName = '${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Location')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Location: $locationName', // Displaying the live location
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
