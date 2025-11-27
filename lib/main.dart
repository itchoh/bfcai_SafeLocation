import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
final Set<Marker> mark={Marker(markerId: MarkerId("1"),position: LatLng(30.4738636,31.199931))};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(title: Text("data"),
      ),
        body: GoogleMap(

          mapType: MapType.normal,
          markers:mark ,
          initialCameraPosition: CameraPosition(target: LatLng(30.4738636,31.199931),zoom: 19,),
          onMapCreated: (GoogleMapController controller) {
           // _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
