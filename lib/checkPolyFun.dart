import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turf/turf.dart' as turf;

bool isInsideAnyPolygon(LatLng userPosition, List<List<LatLng>> polygons) {
  final point = turf.Point(
    coordinates: turf.Position(userPosition.longitude, userPosition.latitude),
  );

  for (var poly in polygons) {
    final positions = poly.map((p) => turf.Position(p.longitude, p.latitude)).toList();
    final polygon = turf.Polygon(coordinates: [positions]);

    if (turf.booleanPointInPolygon(point as turf.Position, polygon)) {
      return true; // User is inside this polygon
    }
  }

  return false; // Not inside any polygon
}
