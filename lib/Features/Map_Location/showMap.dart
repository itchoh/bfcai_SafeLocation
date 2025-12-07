import 'package:bfcai_safe_zone/Features/Map_Location/utils/check.dart';
import 'package:bfcai_safe_zone/Features/Map_Location/utils/checkCircleFun.dart';
import 'package:bfcai_safe_zone/Features/Map_Location/utils/checkPolyFun.dart';
import 'package:bfcai_safe_zone/Features/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Notification/Local_Notification.dart';
import '../../core/utils/app_shared_preference.dart';
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
  List<Circles> userCircles = [];
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
        leading: IconButton(
          onPressed: () {
            AppPreference.removeData("id");
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          },
          icon: Icon(Icons.logout),
        ),
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
                          consumeTapEvents: true,
                          onTap: () async{
                          userPolygons.remove(userPolygons[i]);
                          setState(() {
                          });
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddPolygon(
                                  position: MapService.position,
                                  mapController: MapService.mapController,
                                ),
                              ),
                            );
                            if (result != null && mounted) {
                              setState(() {
                                userPolygons.add(List<LatLng>.from(result));
                              });
                            }
                        },
                      ),
                  },
                  circles:  {
                    for (int i = 0; i < userCircles.length; i++)
                      Circle(
                        circleId: CircleId("user_Circle_$i"),
                        center: userCircles[i].point!,
                        radius: userCircles[i].radius,
                        fillColor: Colors.greenAccent.withOpacity(0.4),
                        strokeWidth: 1,
                        strokeColor: Colors.blue,
                        consumeTapEvents: true,
                        onTap: () async {
                          userCircles.remove(userCircles[i]);
                          setState(() {
                          });
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
                      ),
                  },
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
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
                        if (result != null && mounted) {
                          setState(() {
                            userPolygons.add(List<LatLng>.from(result));
                          });
                        }
                      },
                      child: const Text(
                        "Polygon",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async {
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
                      child: const Text(
                        "Circle",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
