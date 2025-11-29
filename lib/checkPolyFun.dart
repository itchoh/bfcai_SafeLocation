import 'package:turf_dart/turf.dart' as turf;

bool isInsideAnyPolygon(LatLng userPosition, List<List<LatLng>> polygons) {
  final point = turf.Point(turf.Position(userPosition.longitude, userPosition.latitude));

  for (var poly in polygons) {
    final positions = poly
        .map((p) => turf.Position(p.longitude, p.latitude))
        .toList();

    final polygon = turf.Polygon([positions]);

    if (turf.booleanPointInPolygon(point, polygon)) {
      return true; // Found a polygon containing the user
    }
  }
  return false;
}
