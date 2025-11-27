import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/auto_stop_handler.dart';
import 'package:background_locator_2/callback_dispatcher.dart';
import 'package:background_locator_2/keys.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:background_locator_2/utils/settings_util.dart';
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
