import 'package:bfcai_safe_zone/Features/Map_Location/utils/check.dart';
import 'package:bfcai_safe_zone/Features/Map_Location/utils/checkCircleFun.dart';
import 'package:bfcai_safe_zone/Features/Map_Location/utils/checkPolyFun.dart';
import 'package:bfcai_safe_zone/Features/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Local_Notification.dart';
import '../../utils/app_shared_preference.dart';
import 'Add Circle.dart';
import 'Add_Polygon.dart';

import 'utils/determineGeoLocation.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({super.key});
  static String routeName = "showMap";

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  List<List<LatLng>> userPolygons = [];
  List<Circle> userCircles = [];
  bool check1 = true;
  bool check2 = true;
  @override
  void initState() {
    super.initState();

    MapService.startTracking(() {
      if (userPolygons.isNotEmpty) {
        final bool insidePolygon = isInsideAnyPolygon(
          LatLng(MapService.position!.latitude, MapService.position!.longitude),
          userPolygons,
        );

        if (check1 == insidePolygon) {
          LocalNotificationService.showBasicNotification();
          check1 = !check1;
        }
      }
      if (userCircles.isNotEmpty) {
        final bool insideCircle = isInsideAnyCircle(
          LatLng(MapService.position!.latitude, MapService.position!.longitude),
          userCircles,
        );
        if (check2 == insideCircle) {
          LocalNotificationService.showBasicNotification();
          check2 = !check2;
        }
      }
      if (mounted) {
        return setState(() {});
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map Live Tracking"),
        leading: IconButton(onPressed: () {
          AppPreference.removeData("id");
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        }, icon: Icon(Icons.logout)),
      ),
      body: MapService.position == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
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
                    zoom: 19,
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
                  polygons: {
                    for (int i = 0; i < userPolygons.length; i++)
                      Polygon(
                        polygonId: PolygonId("user_poly_$i"),
                        points: userPolygons[i],
                        fillColor: Colors.blueAccent.withOpacity(0.4),
                        strokeWidth: 1,
                        strokeColor: Colors.blue,
                      ),
                  },
                  circles: {...userCircles},
                ),
                buildAlign(
                  context,
                  Alignment.bottomLeft,
                  AddPolygon(
                    position: MapService.position,
                    mapController: MapService.mapController,
                  ),
                  userPolygons,
                ),
                buildAlign(
                  context,
                  Alignment.bottomRight,
                  Add_Circle(
                    position: MapService.position,
                    mapController: MapService.mapController,
                  ),
                  userCircles,
                ),
              ],
            ),
    );
  }

  Align buildAlign(
    BuildContext context,
    Alignment Alignn,
    Widget w,
    List listt,
  ) {
    return Align(
      alignment: Alignn,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return w;
                },
              ),
            );
            if (result != null && mounted) {
              setState(() {
                listt.add(List<LatLng>.from(result));
              });
            }
          },
          child: const Text("Polygon", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
