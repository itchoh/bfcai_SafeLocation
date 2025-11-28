import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  static Position? position;
  static StreamSubscription<Position>? _positionStream;
  static GoogleMapController? mapController;
  static bool _trackingStarted = false;

  // Start location tracking
  static Future<void> startTracking(Function()? onUpdate) async {
    if (_trackingStarted) return; // avoid duplicate streams
    _trackingStarted = true;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Permissions are permanently denied.");
    }

    // Start listening
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position p) {
      position = p;
      onUpdate?.call(); // notify UI
      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLng(LatLng(p.latitude, p.longitude)),
        );
      }
    });
  }

  // Stop tracking (call in dispose)
  static void stopTracking() {
    _positionStream?.cancel();
    _positionStream = null;
    _trackingStarted = false;
  }
}
