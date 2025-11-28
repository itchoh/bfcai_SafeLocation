import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  static Position? position;
  static StreamSubscription<Position>? positionStream;
  static GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    determinePosition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Map Live Tracking")),
      body: position == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            circles: {
              Circle(
                circleId: CircleId("2"),
                center: LatLng(30.174999211815003, 31.203514679362613),

                radius: 50,
                fillColor: Colors.greenAccent.withOpacity(0.4),
                strokeWidth: 0,
              ),
            },
            polygons: {
              Polygon(
                polygonId: PolygonId("1"),
                points: [
                  LatLng(30.176321976537384, 31.200773727805625),
                  LatLng(30.176625612941034, 31.205861636837874),
                  LatLng(30.173874669554504, 31.20598598918641),
                  LatLng(30.17397831334172, 31.201020714858675),
                ],
                fillColor: Colors.greenAccent.withOpacity(0.4),
                strokeWidth: 0,
              ),
            },
            onMapCreated: (controller) {
              mapController = controller;
            },
            mapType: MapType.normal,
            markers: {
              Marker(
                markerId: const MarkerId("me"),
                position: LatLng(position!.latitude, position!.longitude),
                infoWindow: const InfoWindow(title: "You are here"),
              ),
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(position!.latitude, position!.longitude),
              zoom: 17,
            ),
          ),
          Positioned(
            top: 700,
            left: 24,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddPolygon(
                        position: position,
                        mapController: mapController,
                      );
                    },
                  ),
                );
              },
              child: Text("polygon"),
            ),
          ),
          Positioned(
            top: 700,
            right: 24,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Add_Circle(
                      position: position,
                      mapController: mapController,
                    );
                  },
                ),);
              },
              child: Text("Circle"),
            ),
          ),
        ],
      ),
    );
  }
}