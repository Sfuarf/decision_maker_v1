import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:flutter/material.dart';
import 'hero_dialog_route.dart';

class SelectNewVenue extends StatelessWidget {
  final ApplicationBlock applicationBlock;
  const SelectNewVenue({Key? key, required this.applicationBlock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GestureDetector(
        onTap: () async {
          // Open Up a Loading Screen while the app finds a new Venue
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return _SelectNewVenueWaiting();
          }));

          // Send for new Place
          await applicationBlock.searchPlace();

          // Close the top most (the waiting dialog)
          Navigator.pop(context);

          // Open new dialog which will show the new venue
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return _SelectNewVenue(applicationBlock: applicationBlock);
          }));
        },
        child: Center(
          child: Material(
            color: Colors.grey,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.search_rounded,
              color: Colors.black,
              size: 56,
            ),
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroOpenLoading = 'add-selected-venue-hero';

// Final Results page which shows the selected place

class _SelectNewVenue extends StatelessWidget {
  final ApplicationBlock applicationBlock;

  /// {@macro add_todo_popup_card}
  const _SelectNewVenue({Key? key, required this.applicationBlock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _headingTextStyle = TextStyle(color: Colors.black, fontSize: 25);
    TextStyle _valueTextStyle = TextStyle(color: Colors.black, fontSize: 15);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 300,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Hero(
              tag: _heroOpenLoading,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  // padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    // border: Border.all(color: backColor, width: 5),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 17),
                        blurRadius: 17,
                        spreadRadius: -23,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Selected Venue:', style: _headingTextStyle),
                        Text(applicationBlock.selectedAttraction.name,
                            style: _valueTextStyle),
                        Text(applicationBlock.selectedAttraction.address,
                            style: _valueTextStyle),
                        Text('Rating', style: _headingTextStyle),
                        Text(applicationBlock.selectedAttraction.rating,
                            style: _valueTextStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectNewVenueWaiting extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _SelectNewVenueWaiting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroOpenLoading,
          child: Material(
            color: Colors.blue,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// Material(
//             color: Colors.blue,
//             elevation: 2,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Text(
//                         'The Selected Venue is: ${applicationBlock.finalSelectedDestination}'),
//                     Text(
//                         'This has a rating of ${applicationBlock.selectedAttraction.rating}'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
