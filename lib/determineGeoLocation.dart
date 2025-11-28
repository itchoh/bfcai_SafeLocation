import 'dart:async';

import 'package:bfcai_safe_zone/showMap.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
 class MapService{
   static Position? position;
   static StreamSubscription<Position>? positionStream;
   static GoogleMapController? mapController;

   static Future<void> determinePosition() async {
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
       position = p;


       if (mapController != null) {
         mapController!.animateCamera(
           CameraUpdate.newLatLng(LatLng(p.latitude, p.longitude)),
         );
       }
     });
   }
 }