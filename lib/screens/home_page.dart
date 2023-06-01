import 'package:flutter/material.dart';
import 'package:mood_memo/widgets/calendar.dart';

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
          showRatingPopup(setState, null, null, null);
        },
        child: const Icon(Icons.add_reaction, color: Colors.white),
      ),
    );
  }
}
