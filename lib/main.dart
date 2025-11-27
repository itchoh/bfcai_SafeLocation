import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? position;
  StreamSubscription<Position>? positionStream;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1) Check GPS ON/OFF
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    // 2) Check permission
    permission = await Geolocator.checkPermission();

    // If denied → ask again
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied.");
      }
    }

    // If denied forever → user must enable manually
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Permissions are permanently denied.");
    }

    // 3) Start location stream
    positionStream = Geolocator.getPositionStream().listen((Position p) {
      setState(() {
        position = p;
      });

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLng(LatLng(p.latitude, p.longitude)),
        );
      }
    });
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Google Map Live Tracking")),
        body: position == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(onPressed: (){}, child: Text("polygon"),),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(onPressed: (){}, child: Text("Circle"),),
                  )
                ],
              ),
      ),
    );
  }
}
