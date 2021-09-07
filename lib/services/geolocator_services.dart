import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  bool taskCompleted = false;
  bool locationPermission = false;

  Future<bool> checkCurrentPermissions() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    print(permission.toString());
    if (permission != LocationPermission.denied) {
      return true;
    } else {
      return false;
    }
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Services are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Can not request location');
    }
    taskCompleted = true;
    return await Geolocator.getCurrentPosition();
  }
}
