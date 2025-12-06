import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turf/turf.dart' as turf;

bool isInsideAnyPolygon(LatLng userPosition, List<List<LatLng>> polygons) {
  final point = turf.Point(
    coordinates: turf.Position(userPosition.longitude, userPosition.latitude),
  );

  for (var poly in polygons) {

    final positions = poly.map((p) => turf.Position(p.longitude, p.latitude)).toList();

    if (positions.first != positions.last) {
      positions.add(positions.first);
    }

    final polygon = turf.Polygon(coordinates: [positions]);

    if (turf.booleanPointInPolygon(point.coordinates, polygon)) {
      return true;
    }
  }

  return false;
}
