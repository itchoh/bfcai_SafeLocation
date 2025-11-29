import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Add Circle.dart';
import 'Add_Polygon.dart';
import 'checkCircleFun.dart';
import 'checkPolyFun.dart';
import 'determineGeoLocation.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({super.key});

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  List<List<LatLng>> userPolygons = [];
  List<Circle> userCircles = [];

  @override
  void initState() {
    super.initState();

    // Start tracking position
    MapService.startTracking(() {
      if (mounted) setState(() {});
      if(userPolygons.isNotEmpty){
      final bool insidePolygon = isInsideAnyPolygon(LatLng(
        MapService.position!.latitude,
        MapService.position!.longitude,
      ), userPolygons);
      print("$insidePolygon polygon");
      }
      else{
        /*showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Alert Dialog Box"),
              content: const Text("You have raised an Alert Dialog Box"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(14),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),*/
        print("List of Polygon is empty");
      }
      if(userCircles.isNotEmpty) {
        final bool insideCircle = isInsideAnyCircle(LatLng(
          MapService.position!.latitude,
          MapService.position!.longitude,
        ), userCircles);
        print("${insideCircle} circle ");
      }
      else{
        print ("List of Circle is empty ");
      }
    });
  }

  @override
  void dispose() {
    MapService.stopTracking();
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
            padding: const EdgeInsets.only(bottom: 70),
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

            /// polygons shown here
            polygons: {
              /// polygon returned from AddPolygon
              for (int i = 0; i < userPolygons.length; i++)
                Polygon(
                  polygonId: PolygonId("user_poly_$i"),
                  points: userPolygons[i],
                  fillColor: Colors.blueAccent.withOpacity(0.4),
                  strokeWidth: 1,
                  strokeColor: Colors.blue,
                ),

              /// fixed example polygon
              Polygon(
                polygonId: const PolygonId("fixed"),
                points: const [
                  LatLng(30.176321, 31.200773),
                  LatLng(30.176625, 31.205861),
                  LatLng(30.173874, 31.205985),
                  LatLng(30.173978, 31.201020),
                ],
                fillColor: Colors.greenAccent.withOpacity(0.4),
                strokeWidth: 0,
              ),
            },

            /// circles example
            circles: {
              ...userCircles
            },
          ),

          // Polygon button
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddPolygon(
                        position: MapService.position,
                        mapController: MapService.mapController,
                      ),
                    ),
                  );

                  /// If user pressed save
                  if (result != null && mounted) {
                    setState(() {
                      userPolygons.add(List<LatLng>.from(result));
                    });
                  }
                },
                child: const Text("Polygon",style: TextStyle(color: Colors.white),),
              ),
            ),
          ),

          // Circle button
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                onPressed: () async{
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Add_Circle(
                        position: MapService.position,
                        mapController: MapService.mapController,
                      ),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      userCircles.add(result);
                    });
                  }
                },
                child: const Text("Circle",style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
