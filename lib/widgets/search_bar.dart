import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController placeTypeSearch;

  SearchBar({required this.placeTypeSearch});

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
        controller: placeTypeSearch,
        decoration: InputDecoration(
          hintText: "Filter Options",
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
