import 'package:flutter/material.dart';

class PlaceCard {
  final String id;
  final String imageTitle;
  final String title;
  final String placeType;
  final VoidCallback press;
  bool selected;
  Color backGroundColor;

  PlaceCard({
    required this.id,
    required this.imageTitle,
    required this.title,
    required this.placeType,
    required this.press,
    required this.selected,
    required this.backGroundColor,
  });
}

List<PlaceCard> createPlaceCardList() {
  List<PlaceCard> _list = [];
  _list = [];
  _list.add(
    PlaceCard(
      id: '1',
      imageTitle: 'assets/images/cafe_icon.png',
      title: 'Cafe',
      placeType: 'cafe',
      press: () {},
      selected: false,
      backGroundColor: Colors.grey,
    ),
  );
  _list.add(
    PlaceCard(
      id: '2',
      imageTitle: 'assets/images/restaurant_image.png',
      title: 'Restaurant',
      placeType: 'restaurant',
      press: () {},
      selected: false,
      backGroundColor: Colors.grey,
    ),
  );
  _list.add(
    PlaceCard(
      id: '3',
      imageTitle: 'assets/images/bar_image.png',
      title: 'Bar',
      placeType: 'bar',
      press: () {},
      selected: false,
      backGroundColor: Colors.grey,
    ),
  );
  _list.add(
    PlaceCard(
      id: '4',
      imageTitle: 'assets/images/take_away_image.png',
      title: 'Take Away',
      placeType: 'meal_take_away',
      press: () {},
      selected: false,
      backGroundColor: Colors.grey,
    ),
  );

  return _list;
}

List<PlaceCard> buildSearchList(String searchText, List<PlaceCard> list) {
  List<PlaceCard> searchList = [];

  if (searchText.isEmpty) {
    return searchList = list;
  } else {
    searchList = list
        .where((element) =>
            element.placeType
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            element.placeType.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    print('${searchList.length}');
    return searchList; //_searchList.map((contact) =>  Uiitem(contact)).toList();
  }
}
