import 'package:decision_maker_v1/models/geometry.dart';
import 'package:decision_maker_v1/models/location.dart';
import 'package:decision_maker_v1/models/place.dart';
import 'package:decision_maker_v1/models/place_search.dart';
import 'package:decision_maker_v1/services/geolocator_services.dart';
import 'package:decision_maker_v1/services/places_service.dart';
import 'package:decision_maker_v1/widgets/use_current_location_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_state_button/progress_button.dart';

class ApplicationBlock with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placesService = PlacesService();

  // Variables
  late List<PlaceSearch> searchResults;

  // Status Variables
  bool currentPositionFound = false;

// Define empty list of strings to hold the place types selected.

  late Position currentLocation;
  List<String> placeTypes = [];

  // This is a work-around! Needs to be fixed in the future!
  late Place initialPosition;
  late Place newPlaceSelected;

  // Functions

  setCurrentLocation() async {
    currentPositionFound = false;
    print('Making it here?');

    currentLocation =
        await geolocatorService.getCurrentLocation().then((value) {
      currentPositionFound = true;
      print('Current Loaction Found');

      notifyListeners();

      return value;
    }).onError((error, stackTrace) {
      print('This is the current error occuring $error');
      return currentLocation;
    });
  }

  modifyPlaceType(String value, bool selected) {
    if (selected) {
      placeTypes.add(value);
    } else {
      placeTypes.remove(value);
    }
    print(placeTypes);
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }
}
