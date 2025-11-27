import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? position;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied.');
    }

    Position pos = await Geolocator.getCurrentPosition();
    setState(() {
      position = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Google Map")),
        body: position == null
            ? Center(child: CircularProgressIndicator())
            : GoogleMap(
          mapType: MapType.normal,
          markers: {
            Marker(
              markerId: MarkerId("1"),
              position:
              LatLng(position!.latitude, position!.longitude),
            ),
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(position!.latitude, position!.longitude),
            zoom: 18,
          ),
        ),
      ),
    );
  }
}
