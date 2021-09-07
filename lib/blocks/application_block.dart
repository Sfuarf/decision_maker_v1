import 'dart:async';
import 'dart:math';

import 'package:decision_maker_v1/models/geometry.dart';
import 'package:decision_maker_v1/models/location.dart';
import 'package:decision_maker_v1/models/place.dart';
import 'package:decision_maker_v1/models/place_search.dart';
import 'package:decision_maker_v1/services/geolocator_services.dart';
import 'package:decision_maker_v1/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ApplicationBlock with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placesService = PlacesService();

  // Stream Controllers
  StreamController<Place> selectedLocation =
      StreamController<Place>.broadcast();
  StreamController<Position> subCurrentPosition =
      StreamController<Position>.broadcast();

  // Variables
  late List<PlaceSearch> searchResults;

  // Status Variables
  bool currentPositionFound = false;
  bool selectedPositionFound = false;
  // Status to show if using current position or selected position
  String currentPositonSelectedPosition = 'Neither';

// Define empty list of strings to hold the place types selected.

  late Position currentPosition;
  late Position selectedPosition;
  List<String> placeTypes = [];

  // This is a work-around! Needs to be fixed in the future!
  late Place initialPosition;
  late Place selectedPlace;
  late Place currentPlace;

  late Place newPlaceSelected;

  // Functions

  setCurrentLocation() async {
    currentPositionFound = false;
    print('Making it here?');

    currentPosition =
        await geolocatorService.getCurrentLocation().then((value) {
      currentPositionFound = true;

      print('Current Loaction Found');

      notifyListeners();

      return value;
    });

    currentPositonSelectedPosition = 'Current';

    subCurrentPosition.add(currentPosition);
    // Define new Place (for using _goToPlace Function)

    currentPlace = Place(
        name: '',
        address: '',
        geometry: Geometry(
            location: Location(
                lat: currentPosition.latitude,
                lng: currentPosition.longitude)));
  }

  modifyPlaceType(String value, bool selected) {
    if (selected) {
      placeTypes.add(value);
    } else {
      placeTypes.remove(value);
    }
    print(placeTypes);
  }

  // Return a list of the google autocompleted places
  // These will be shown under the search bar on the start page
  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }

  // Change the location to the one selected from the autocompleted list
  setSelectedLocation(String placeId) async {
    // Search Google for the Place information given the placeId tag
    // This placeId is given from the autocomplete search
    // This then returns Lat, Long etc. values to locate on the map
    selectedPlace = await placesService.getPlace(placeId).then((value) {
      selectedPositionFound = true;
      return value;
    });
    selectedLocation.add(selectedPlace);
    currentPositonSelectedPosition = 'Selected';
    // initialPosition = sLocation;
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    subCurrentPosition.close();
    super.dispose();
  }
}
