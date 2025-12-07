import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turf/turf.dart' as turf;

import '../Add Circle.dart';

bool isInsideAnyCircle(LatLng userPos, List<Circles> circles) {
  for (var circle in circles) {
    final dist = turf.distance(
      turf.Point(coordinates: turf.Position(userPos.longitude, userPos.latitude)),
      turf.Point(coordinates: turf.Position(circle.point!.longitude, circle.point!.latitude)),
    );

    if (dist * 1000 <= circle.radius) {
      return true;
    }
  }
  return false;
}
