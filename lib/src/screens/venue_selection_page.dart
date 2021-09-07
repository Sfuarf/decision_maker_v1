import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:decision_maker_v1/src/screens/start_page.dart';
import 'package:decision_maker_v1/widgets/category_card.dart';
import 'package:decision_maker_v1/widgets/place_card.dart';
import 'package:decision_maker_v1/widgets/search_bar.dart';
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
                        child: SvgPicture.asset("assets/icons/menu.svg"),
                      ),
                    ),
                  ),
                  Text(
                    "Choose Your Venue!?",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SearchBar(placeTypeSearch: _searchQuery),
                  Expanded(
                    child: GridView.builder(
                      itemCount: _searchList.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          placeCard: _searchList[index],
                          applicationBlock: widget.applicationBlock,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .85,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          await widget.applicationBlock.searchPlace();

                          final snackBar = SnackBar(
                            content: Text(
                                'The Chosen Place is: ${widget.applicationBlock.finalSelectedDestination}'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text('Find Random Location')),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
