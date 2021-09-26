import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:decision_maker_v1/src/screens/start_page.dart';
import 'package:decision_maker_v1/widgets/category_card.dart';
import 'package:decision_maker_v1/widgets/place_card.dart';
import 'package:decision_maker_v1/widgets/search_bar.dart';
import 'package:decision_maker_v1/widgets/selected_location_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VenueSelectionPage extends StatefulWidget {
  VenueSelectionPage({
    Key? key,
    required this.title,
    required this.applicationBlock,
  }) : super(key: key);

  final String title;
  final ApplicationBlock applicationBlock;

  @override
  _VenueSelectionPage createState() => _VenueSelectionPage();
}

class _VenueSelectionPage extends State<VenueSelectionPage> {
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<PlaceCard> _searchList = [];
  List<PlaceCard> _list = [];

  String _searchText = "";

  _VenueSelectionPage() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _searchText = "";
          _searchList = buildSearchList(_searchText, _list);
        });
      } else {
        setState(() {
          _searchText = _searchQuery.text;
          _searchList = buildSearchList(_searchText, _list);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _list = createPlaceCardList();
    _searchList = _list;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.45,
            decoration: BoxDecoration(
              color: Color.fromRGBO(141, 245, 66, 100),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartScreen()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Choose Your Type of Venue!?",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SearchBar(placeTypeSearch: _searchQuery),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _searchList.length,
                      itemBuilder: (context, index) {
                        return SwitchListTile(
                            title: Text(_searchList[index].title),
                            value: _searchList[index].selected,
                            secondary: Image.asset(
                              _searchList[index].imageTitle,
                              height: 48,
                              width: 48,
                            ),
                            onChanged: (bool value) {
                              setState(() {
                                _searchList[index].selected = value;
                                widget.applicationBlock.modifyPlaceType(
                                    _searchList[index].placeType,
                                    _searchList[index].selected);
                              });
                            });
                        /*return CategoryCard(
                          placeCard: _searchList[index],
                          applicationBlock: widget.applicationBlock,
                        ); */
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: SelectNewVenue(
                      applicationBlock: widget.applicationBlock,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
