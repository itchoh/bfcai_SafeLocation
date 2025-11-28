import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddPolygon extends StatefulWidget {
  AddPolygon({super.key, required this.position, required this.mapController});
  final Position? position;
  GoogleMapController? mapController;

  @override
  State<AddPolygon> createState() => _AddPolygonState();
}

class _AddPolygonState extends State<AddPolygon> {

  List<LatLng>newlistlatlng=[];
  late List<Marker>newmarkerlist=[
    Marker(

      markerId: const MarkerId("me"),
      position: LatLng(
        widget.position!.latitude,
        widget.position!.longitude,
      ),
      infoWindow: const InfoWindow(title: "You are here"),
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Map Live Tracking")),
      body: widget.position == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        onTap: (lat){
          setState(() {
            newlistlatlng.add(lat);
            newmarkerlist.add(Marker(
              markerId: MarkerId("${lat.longitude}"),
              position: LatLng(lat.latitude, lat.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // smaller color pin
              infoWindow: InfoWindow(title: "${newmarkerlist.length }"),
            ),
                );
          });

        },
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
          if (newlistlatlng.isNotEmpty)
            Polygon(
              polygonId: const PolygonId("1"),
              points: newlistlatlng,
              fillColor: Colors.greenAccent.withOpacity(0.4),
              strokeWidth: 0,
            ),
        },

        onMapCreated: (controller) {
                widget.mapController = controller;
              },
              mapType: MapType.normal,
              markers:newmarkerlist.toSet(),
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
