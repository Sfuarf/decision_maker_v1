import 'package:decision_maker_v1/widgets/place_card.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CategoryCard extends StatelessWidget {
  final PlaceCard placeCard;

  const CategoryCard({Key? key, required this.placeCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: placeCard.press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Container(
                      height: 120,
                      child: Image(image: AssetImage(placeCard.imageTitle))),
                  Spacer(),
                  Text(
                    placeCard.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
