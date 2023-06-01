import 'package:flutter/material.dart';
import 'package:mood_memo/screens/settings.dart';
import 'package:mood_memo/widgets/calendar.dart';
import 'package:mood_memo/widgets/new_rating_popup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // for navigation bar - currently not used
  /*int _currentIndex = 0;

  final List<Widget> _children = [
    const HomePage(),
    Settings(),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Memo'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings, 
              color: Theme.of(context).unselectedWidgetColor,
              ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
        ],
      ),
      body: Calendar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showRatingPopup(setState, null, null, null);
        },
        child: const Icon(Icons.add_reaction, color: Colors.white),
      ),

      // navigation bar - currently not used
      /*body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),*/
    );
  }
}
