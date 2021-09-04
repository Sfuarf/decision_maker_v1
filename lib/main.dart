import 'package:decision_maker_v1/blocks/application_block.dart';
import 'package:decision_maker_v1/src/screens/start_page.dart';
import 'package:decision_maker_v1/src/screens/venue_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

void main() async {
  await DotEnv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ApplicationBlock(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Decision Maker',
          theme: ThemeData(
            fontFamily: "Cairo",
            scaffoldBackgroundColor: kBackgroundColor,
            textTheme:
                Theme.of(context).textTheme.apply(displayColor: kTextColor),
          ),
          home: StartScreen(),
        ));
  }
}
