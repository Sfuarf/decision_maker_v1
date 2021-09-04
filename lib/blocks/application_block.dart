import 'package:flutter/material.dart';

class ApplicationBlock with ChangeNotifier {
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
}
