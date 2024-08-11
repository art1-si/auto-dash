class GeolocationException implements Exception {
  GeolocationException();
}

/// Thrown when the location permissions are not granted by a user.
class LocationPermissionsNotGrantedException extends GeolocationException {
  LocationPermissionsNotGrantedException();

  @override
  String toString() {
    return 'Location permissions are not granted.';
  }
}
