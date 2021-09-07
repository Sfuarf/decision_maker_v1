import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:decision_maker_v1/src/screens/venue_selection_page.dart';
import 'package:decision_maker_v1/widgets/google_maps_start_page.dart';
import 'package:decision_maker_v1/widgets/location_search_bar.dart';
import 'package:decision_maker_v1/widgets/use_current_location_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  var _textController = TextEditingController();

  late StreamSubscription locationSubscription;
  late StreamSubscription currentLocationSubscription;

  void initState() {
    final applicationBlock =
        Provider.of<ApplicationBlock>(context, listen: false);

    // ignore: cancel_subscriptions
    locationSubscription =
        applicationBlock.selectedLocation.stream.listen((place) {
      _goToPlace(place.geometry.location.lat, place.geometry.location.lng);
    });

    // ignore: cancel_subscriptions
    currentLocationSubscription =
        applicationBlock.subCurrentPosition.stream.listen((posistion) {
      _goToPlace(posistion.latitude, posistion.longitude);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBlock = Provider.of<ApplicationBlock>(context);
    var size = MediaQuery.of(context).size;
    ButtonState useLocationButtonState = ButtonState.idle;

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
                      Text(
                        'OR',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Center(
                        child: ProgressTrackingButton(
                          applicationBlock: applicationBlock,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GoogleMapsStartPage(
                            applicationBlock: applicationBlock,
                            mapController: _mapController),
                      ),
                      (!applicationBlock.currentPositionFound &&
                              !applicationBlock.selectedPositionFound)
                          ? Container()
                          : Container(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.check),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ))),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VenueSelectionPage(
                                                      title: 'The Title',
                                                      applicationBlock:
                                                          applicationBlock)));
                                      applicationBlock.currentPositionFound =
                                          false;
                                      applicationBlock.selectedPositionFound =
                                          false;
                                    },
                                    label: Text('Done'),
                                  )),
                            )
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

  // Move Google Maps to inputted place
  Future<void> _goToPlace(double lat, double long) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          lat,
          long,
        ),
        zoom: 14)));
  }

  @override
  void dispose() async {
    await locationSubscription.cancel();
    await currentLocationSubscription.cancel();
    super.dispose();
  }
}
