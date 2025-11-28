import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Add Circle.dart';
import 'Add_Polygon.dart';
import 'determineGeoLocation.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({super.key});

  @override
  State<ShowMap> createState() => _ShowMapState();
}
class _ShowMapState extends State<ShowMap> {
  @override
  void initState() {
    super.initState();
    // Start tracking and update UI on each position change
    MapService.startTracking(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    MapService.stopTracking(); // prevent duplicate streams
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MapService.position == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Google Map Live Tracking")),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              MapService.mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                MapService.position!.latitude,
                MapService.position!.longitude,
              ),
              zoom: 17,
            ),
            mapType: MapType.normal,
            markers: {
              Marker(
                markerId: const MarkerId("me"),
                position: LatLng(
                  MapService.position!.latitude,
                  MapService.position!.longitude,
                ),
                infoWindow: const InfoWindow(title: "You are here"),
              ),
            },
            circles: {
              Circle(
                circleId: const CircleId("2"),
                center: LatLng(30.174999, 31.203514),
                radius: 50,
                fillColor: Colors.greenAccent.withOpacity(0.4),
                strokeWidth: 0,
              ),
            },
            polygons: {
              Polygon(
                polygonId: const PolygonId("1"),
                points: [
                  LatLng(30.176321, 31.200773),
                  LatLng(30.176625, 31.205861),
                  LatLng(30.173874, 31.205985),
                  LatLng(30.173978, 31.201020),
                ],
                fillColor: Colors.greenAccent.withOpacity(0.4),
                strokeWidth: 0,
              ),
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddPolygon(
                      position: MapService.position,
                      mapController: MapService.mapController,
                    ),
                  ),
                );
              },
              child: const Text("Polygon"),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Add_Circle(
                      position: MapService.position,
                      mapController: MapService.mapController,
                    ),
                  ),
                );
              },
              child: const Text("Circle"),
            ),
          ),
        ],
      ),
    );
  }
}
