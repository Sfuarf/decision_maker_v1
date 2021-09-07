import 'dart:async';

import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:decision_maker_v1/models/place.dart';
import 'package:decision_maker_v1/services/geolocator_services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class ProgressTrackingButton extends StatefulWidget {
  final VoidCallback press;
  final ApplicationBlock applicationBlock;

  const ProgressTrackingButton({
    Key? key,
    required this.applicationBlock,
    required this.press,
  }) : super(key: key);

  @override
  _ProgressTrackingButtonState createState() => _ProgressTrackingButtonState();
}

class _ProgressTrackingButtonState extends State<ProgressTrackingButton> {
  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return ProgressButton.icon(
        iconedButtons: {
          ButtonState.idle: IconedButton(
              text: "Use Current Location",
              icon: Icon(Icons.location_searching, color: Colors.white),
              color: Colors.grey),
          ButtonState.loading:
              IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
          ButtonState.fail: IconedButton(
              text: "Failed",
              icon: Icon(Icons.cancel, color: Colors.white),
              color: Colors.red.shade300),
          ButtonState.success: IconedButton(
              text: "Success",
              icon: Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              color: Colors.green.shade400)
        },
        onPressed: () async {
          var tempBool = await GeolocatorService().checkCurrentPermissions();

          if (tempBool) {
            setState(() {
              stateTextWithIcon = ButtonState.loading;
            });
            await widget.applicationBlock.setCurrentLocation();

            if (widget.applicationBlock.currentPositionFound) {
              stateTextWithIcon = ButtonState.success;
            }
          } else {
            setState(() {
              stateTextWithIcon = ButtonState.fail;
            });
          }
        },
        state: stateTextWithIcon);
  }
}
