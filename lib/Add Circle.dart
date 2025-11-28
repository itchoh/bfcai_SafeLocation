import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Add_Circle extends StatefulWidget {
  Add_Circle({
    super.key,
    required this.position,
    required this.mapController,
  });

  final Position? position;
  GoogleMapController? mapController;

  @override
  State<Add_Circle> createState() => _Add_CircleState();
}

class _Add_CircleState extends State<Add_Circle> {
  LatLng? point;
  double radius = 100; // default radius in meters

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Circle")),
      body: Stack(
        children: [
          GoogleMap(
            padding: const EdgeInsets.only(bottom: 70),
            onTap: (lat) {
              setState(() {
                point = lat;
              });
            },
            circles: {
              if (point != null)
                Circle(
                  circleId: const CircleId("temp"),
                  center: point!,
                  radius: radius,
                  fillColor: Colors.greenAccent.withOpacity(0.4),
                  strokeWidth: 0,
                  strokeColor: Colors.green,
                ),
            },
            onMapCreated: (controller) {
              widget.mapController = controller;
            },
            markers: {
              Marker(
                markerId: const MarkerId("me"),
                position: LatLng(
                  widget.position!.latitude,
                  widget.position!.longitude,
                ),
                infoWindow: const InfoWindow(title: "You are here"),
              ),
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.position!.latitude,
                widget.position!.longitude,
              ),
              zoom: 17,
            ),
          ),

          // Slider لتحديد نصف القطر
          if (point != null)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Circle Radius (meters)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: radius,
                      min: 50,
                      max: 500,
                      divisions: 9,
                      label: "${radius.toInt()} m",
                      onChanged: (value) {
                        setState(() {
                          radius = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

          // زر Save
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  if (point == null) return;

                  Navigator.pop(
                    context,
                    Circle(
                      circleId: CircleId("${DateTime.now()}"),
                      center: point!,
                      radius: radius,
                      fillColor: Colors.greenAccent.withOpacity(0.4),
                      strokeWidth: 1,
                      strokeColor: Colors.blue,                        ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Save Circle"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
