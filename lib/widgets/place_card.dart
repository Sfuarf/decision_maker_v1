import 'package:flutter/material.dart';

class PlaceCard {
  final String id;
  final String imageTitle;
  final String title;
  final String placeType;
  final VoidCallback press;

  PlaceCard({
    required this.id,
    required this.imageTitle,
    required this.title,
    required this.placeType,
    required this.press,
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
    ),
  );
  _list.add(
    PlaceCard(
      id: '2',
      imageTitle: 'assets/images/restaurant_image.png',
      title: 'Restaurant',
      placeType: 'restaurant',
      press: () {},
    ),
  );
  _list.add(
    PlaceCard(
      id: '3',
      imageTitle: 'assets/images/bar_image.png',
      title: 'Bar',
      placeType: 'bar',
      press: () {},
    ),
  );
  _list.add(
    PlaceCard(
      id: '4',
      imageTitle: 'assets/images/take_away_image.png',
      title: 'Take Away',
      placeType: 'meal_take_away',
      press: () {},
    ),
  );

  return _list;
}
