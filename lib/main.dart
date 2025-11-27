import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
void  main() {
  runApp( MyApp());

}
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Position? position;
   _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    position= await Geolocator.getCurrentPosition();
  }

  void initState(){
    super.initState();
    _determinePosition();
  }

 late final Set<Marker> mark={Marker(markerId: MarkerId("1"),position: LatLng(position!.latitude,position!.longitude))};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(title: Text("data"),
      ),
        body: GoogleMap(

          mapType: MapType.normal,
          markers:mark ,
          initialCameraPosition: CameraPosition(target: LatLng(position!.latitude,position!.longitude),zoom: 19,),
          onMapCreated: (GoogleMapController controller) {
           // _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
