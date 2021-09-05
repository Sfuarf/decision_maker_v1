import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:decision_maker_v1/src/screens/venue_selection_page.dart';
import 'package:decision_maker_v1/widgets/location_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  var _textController = TextEditingController();

  void initState() {
    final applicationBlock =
        Provider.of<ApplicationBlock>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBlock = Provider.of<ApplicationBlock>(context);
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
          SingleChildScrollView(
            child: Container(
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
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
                      Text(
                        "Select Your Location.",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      LocationSearchBar(
                        placeTypeSearch: _textController,
                        applicationBlock: applicationBlock,
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VenueSelectionPage(
                                          title: 'Test',
                                          applicationBlock: applicationBlock)));
                            },
                            child: const Text('Find Random Location')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
