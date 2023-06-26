import 'package:flutter/material.dart';
import 'package:mood_memo/screens/settings.dart';
import 'package:mood_memo/widgets/calendar.dart';
import 'package:mood_memo/screens/list.dart';
import 'package:mood_memo/widgets/new_rating_popup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Calendar(),
    const RatingList(),
  ];

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showRatingPopup(setState, null, null, null);
        },
        child: const Icon(Icons.add_reaction, color: Colors.white),
      ),

      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'List',
          ),
        ],
      ),
    );
  }
}
