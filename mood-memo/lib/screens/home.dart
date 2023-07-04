import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mood_memo/controllers/list_controller.dart';
import 'package:mood_memo/models/rating.dart';
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
  RatingListController controller = RatingListController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Calendar(),
      RatingList(controller: controller),
    ];

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
          showRatingPopup((_) {
            setState(() {
              if (_currentIndex == 1) {
                controller.pagingController.refresh();
              }
            });
          }, null, null, null);
        },
        child: const Icon(Icons.add_reaction, color: Colors.white),
      ),
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 1) {
            controller.pagingController = PagingController<int, Rating>(
              firstPageKey: 0,
            );
          }
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
