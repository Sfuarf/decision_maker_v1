import 'dart:async';
import 'dart:math';

import 'package:decision_maker_v1/models/attraction.dart';
import 'package:decision_maker_v1/models/geometry.dart';
import 'package:decision_maker_v1/models/location.dart';
import 'package:decision_maker_v1/models/place.dart';
import 'package:decision_maker_v1/models/place_search.dart';
import 'package:decision_maker_v1/services/geolocator_services.dart';
import 'package:decision_maker_v1/services/markers_service.dart';
import 'package:decision_maker_v1/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApplicationBlock with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();

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

  String finalSelectedDestination = '';
  String finalSelectedPlaceType = '';

  late List<Marker> markers = [];

// Define empty list of strings to hold the place types selected.

  late Position currentPosition;
  late Position selectedPosition;
  List<String> placeTypes = [];

  // This is a work-around! Needs to be fixed in the future!
  late Place intialPlace;
  late Place selectedPlace;
  late Place currentPlace;

  late Attraction selectedAttraction;

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

    intialPlace = currentPlace;
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
    intialPlace = selectedPlace;
    currentPositonSelectedPosition = 'Selected';
    // initialPosition = sLocation;
    notifyListeners();
  }

  searchPlace() async {
    if (placeTypes.isEmpty) {
      finalSelectedDestination = '';
      finalSelectedPlaceType = '';
      return [];
    } else {
      // Chose random index of place types selected
      Random randomPlaceType = new Random();
      int randomPlaceIndex = randomPlaceType.nextInt((placeTypes.length));

      // Selected type is then passed into the google search
      var selectedPlaceType = placeTypes[randomPlaceIndex];
      // Local variable for future reference - might be deleted once 'Place' format is used!
      finalSelectedPlaceType = selectedPlaceType;
      print(selectedPlaceType);

      var places = await placesService
          .getAttractions(intialPlace.geometry.location.lat,
              intialPlace.geometry.location.lng, selectedPlaceType)
          .then((value) {
        markers = [];

        // Randomly select an index from the outputted list!
        Random randomPlaceIndex = new Random();
        int randomIndex = randomPlaceIndex.nextInt((value.length));

        finalSelectedDestination = value[randomIndex].name;
        selectedAttraction = value[randomIndex];

        if (value.length > 0) {
          var newMarker =
              markerService.createMarkerFromPlace(value[randomIndex]);
          markers.add(newMarker);
        }

        return value;
      }).onError((error, stackTrace) {
        print('The string being passed was: $finalSelectedPlaceType');
        print('This is the current error occuring $error');
        return [];
      });
    }
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    subCurrentPosition.close();
    super.dispose();
  }
}
