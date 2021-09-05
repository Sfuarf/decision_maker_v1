import 'package:decision_maker_v1/models/place_search.dart';
import 'package:decision_maker_v1/services/places_service.dart';
import 'package:flutter/material.dart';

class ApplicationBlock with ChangeNotifier {
  final placesService = PlacesService();

  // Variables
  late List<PlaceSearch> searchResults;

// Define empty list of strings to hold the place types selected.
  List<String> placeTypes = [];

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
