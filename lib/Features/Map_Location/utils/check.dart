import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Local_Notification.dart';
import 'checkCircleFun.dart';
import 'checkPolyFun.dart';
import 'determineGeoLocation.dart';

checkZone( List<List<LatLng>> userPolygons ,List<Circle> userCircles,bool mounted) {
  bool check1 = true;
  bool check2 = true;
  MapService.startTracking(() {
    if(userPolygons.isNotEmpty){
      final bool insidePolygon = isInsideAnyPolygon(LatLng(
        MapService.position!.latitude,
        MapService.position!.longitude,
      ), userPolygons);

      if (check1==insidePolygon){
        LocalNotificationService.showBasicNotification();
        check1=!check1;
      }
    }
    if(userCircles.isNotEmpty) {
      final bool insideCircle = isInsideAnyCircle(LatLng(
        MapService.position!.latitude,
        MapService.position!.longitude,
      ), userCircles);
      if (check2==insideCircle){
        LocalNotificationService.showBasicNotification();
        check2=!check2;
      }
    }
    if (mounted) {
      return true;
    }
    else {
      false;
    }
  });
}