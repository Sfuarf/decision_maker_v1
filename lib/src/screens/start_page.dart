import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:decision_maker_v1/models/place.dart';
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

  void initState() {
    final applicationBlock =
        Provider.of<ApplicationBlock>(context, listen: false);

    // ignore: cancel_subscriptions
    StreamSubscription locationSubscription =
        applicationBlock.selectedLocation.stream.listen((place) {
      _goToPlace(place);
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
                          press: () {},
                        ),
                      ),
                      (!applicationBlock.currentPositionFound &&
                              !applicationBlock.selectedPositionFound)
                          ? CircularProgressIndicator()
                          : GoogleMapsStartPage(
                              applicationBlock: applicationBlock,
                              mapController: _mapController)
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
  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          place.geometry.location.lat,
          place.geometry.location.lng,
        ),
        zoom: 14)));
  }

  // Move Google Maps to inputted place
  Future<void> _goToPosition(Position position) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          position.latitude,
          position.longitude,
        ),
        zoom: 14)));
  }
}
