import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:decision_maker_v1/widgets/place_card.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CategoryCard extends StatefulWidget {
  final PlaceCard placeCard;
  final ApplicationBlock applicationBlock;

  const CategoryCard(
      {Key? key, required this.placeCard, required this.applicationBlock})
      : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  Color backColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.placeCard.backGroundColor,
          borderRadius: BorderRadius.circular(13),
          // border: Border.all(color: backColor, width: 5),
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
            // When the card is selected, change the background colour
            // Update the internal 'selected' tag so this state will be saved and called back
            onTap: () {
              print('ON TAP BEING TRIGGERED!');
              setState(() {
                widget.placeCard.selected = !widget.placeCard.selected;

                backColor = Colors.blue;
                if (widget.placeCard.selected) {
                  widget.placeCard.backGroundColor = Colors.lightGreen;
                  print('Selected is True');
                } else {
                  widget.placeCard.backGroundColor = Colors.grey;
                  print('Selected is not True');
                }
              });
              widget.applicationBlock.modifyPlaceType(
                  widget.placeCard.title, widget.placeCard.selected);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Container(
                      height: 120,
                      child: Image(
                          image: AssetImage(widget.placeCard.imageTitle))),
                  Spacer(),
                  Text(
                    widget.placeCard.title,
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
