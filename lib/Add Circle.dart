import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Add_Circle extends StatefulWidget {
   Add_Circle({super.key,required this.position, required this.mapController});
  final Position? position;
  GoogleMapController? mapController;

  @override
  State<Add_Circle> createState() => _Add_CircleState();
}

class _Add_CircleState extends State<Add_Circle> {
  LatLng? point;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Map Live Tracking")),
      body: widget.position == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        onTap: (lat){
          setState(() {
           point=lat;
          });

        },
        circles: {
          if (point!=null)
              Circle(
                circleId: CircleId("2"),
                center: point!,
                radius: 100,
                fillColor: Colors.greenAccent.withOpacity(0.4),
                strokeWidth: 0,
              ),
        },
        onMapCreated: (controller) {
          widget.mapController = controller;
        },
        mapType: MapType.normal,
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
    );
  }
}
