import 'dart:async';
import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMapsStartPage extends StatefulWidget {
  final ApplicationBlock applicationBlock;
  final Completer<GoogleMapController> mapController;

  const GoogleMapsStartPage(
      {Key? key, required this.applicationBlock, required this.mapController})
      : super(key: key);

  @override
  _GoogleMapsStartPageState createState() => _GoogleMapsStartPageState();
}

class _GoogleMapsStartPageState extends State<GoogleMapsStartPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.applicationBlock.currentPositionFound) {
      return Container(
        height: 300.0,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.applicationBlock.currentPosition.latitude,
                widget.applicationBlock.currentPosition.longitude),
            zoom: 14,
          ),
          onMapCreated: (GoogleMapController controller) {
            widget.mapController.complete(controller);
          },
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
        ),
      );
    } else if (widget.applicationBlock.selectedPositionFound) {
      return Container(
        height: 300.0,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
                widget.applicationBlock.selectedPlace.geometry.location.lat,
                widget.applicationBlock.selectedPlace.geometry.location.lat),
            zoom: 14,
          ),
          onMapCreated: (GoogleMapController controller) {
            widget.mapController.complete(controller);
          },
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
        ),
      );
    } else {
      return Container(
        height: 300,
        child: CircularProgressIndicator(),
      );
    }
  }
}
