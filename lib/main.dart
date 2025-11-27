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
  GoogleMapController? mapController; // control the camera

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  ///-------------------------------
  /// 1) REQUEST PERMISSIONS + START STREAM
  ///-------------------------------
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

      // Move camera when user moves
      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(p.latitude, p.longitude),
          ),
        );
      }
    });
  }

  ///-------------------------------
  /// 2) CLEAN STREAM WHEN CLOSE APP
  ///-------------------------------
  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  ///-------------------------------
  /// 3) UI + GOOGLE MAP
  ///-------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Google Map Live Tracking")),
        body: position == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
          onMapCreated: (controller) {
            mapController = controller;
          },
          mapType: MapType.normal,

          markers: {
            Marker(
              markerId: const MarkerId("me"),
              position: LatLng(position!.latitude, position!.longitude),
              infoWindow: const InfoWindow(
                title: "You are here",
              ),
            ),
          },

          initialCameraPosition: CameraPosition(
            target: LatLng(position!.latitude, position!.longitude),
            zoom: 17,
          ),
        ),
      ),
    );
  }
}
