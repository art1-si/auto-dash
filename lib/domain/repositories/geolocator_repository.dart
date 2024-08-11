import 'package:auto_dash/domain/exceptions/geolocation_exception.dart';
import 'package:geolocator/geolocator.dart';

/// Repository for accessing the device's geolocation.
///
/// This repository uses the [Geolocator] package to access the device's geolocation.
class GeolocatorRepository {
  final LocationSettings _locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(locationSettings: _locationSettings);
  }

  /// Checks if the app has permission to access the device's location.
  ///
  /// If the app does not have permission, it will request it.
  /// When the app does not have permission and the user denies the request,
  /// a [LocationPermissionsNotGrantedException] will be thrown.
  Future<void> checkPermissions() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        throw LocationPermissionsNotGrantedException();
      }
    }
  }
}
