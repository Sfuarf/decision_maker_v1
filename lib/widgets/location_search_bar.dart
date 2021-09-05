import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:flutter/material.dart';

class LocationSearchBar extends StatelessWidget {
  final TextEditingController placeTypeSearch;
  final ApplicationBlock applicationBlock;

  LocationSearchBar(
      {required this.placeTypeSearch, required this.applicationBlock});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        onChanged: (value) => applicationBlock.searchPlaces(value),
        controller: placeTypeSearch,
        decoration: InputDecoration(
          hintText: "Search Location",
          icon: Icon(Icons.search),
          border: InputBorder.none,
          suffixIcon: IconButton(
              onPressed: () {
                placeTypeSearch.clear();
                FocusScopeNode currentFocus = FocusScope.of(context);

                currentFocus.unfocus();
              },
              icon: Icon(Icons.clear)),
        ),
      ),
    );
  }
}
