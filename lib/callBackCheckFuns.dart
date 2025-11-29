void checkUserLocation() {
  final userPos = LatLng(
    MapService.position!.latitude,
    MapService.position!.longitude,
  );

  final insidePolygon = isInsideAnyPolygon(userPos, userPolygons);
  final insideCircle  = isInsideAnyCircle(userPos, userCircles);

  if (insidePolygon || insideCircle) {
    print("✅ User is inside a geofence");
  } else {
    print("❌ User is outside all geofences");
  }
}
