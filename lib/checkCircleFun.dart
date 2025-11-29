import 'package:turf_dart/turf.dart' as turf;

bool isInsideAnyCircle(LatLng userPos, List<Circle> circles) {
  for (var circle in circles) {
    final dist = turf.distance(
      turf.Point(turf.Position(userPos.longitude, userPos.latitude)),
      turf.Point(turf.Position(circle.center.longitude, circle.center.latitude)),
    );

    if (dist * 1000 <= circle.radius) {
      return true;
    }
  }
  return false;
}
