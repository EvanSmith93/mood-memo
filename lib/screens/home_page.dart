// stateful widget called HomePage
import 'package:flutter/material.dart';
//import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mood_log/screens/settings.dart';
import 'package:mood_log/widgets/calendar.dart';
import 'package:mood_log/widgets/new_rating.dart';

import '../widgets/new_rating_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Calendar(),
      // button that pulls up the rate day screen from the bottom
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showRatingPopup(context, setState, null);
        },
        child: const Icon(Icons.add_reaction),
      ),
    );
  }
}
