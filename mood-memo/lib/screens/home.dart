import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mood_memo/controllers/list_controller.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/screens/settings.dart';
import 'package:mood_memo/widgets/calendar/calendar.dart';
import 'package:mood_memo/widgets/list/list.dart';
import 'package:mood_memo/screens/edit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  // move this to a separate file
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
            onPressed: () async {
              bool refresh = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );

              if (refresh == true) {
                setState(() {});
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditPopup((_) {
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
            // controller.pagingController = PagingController<int, Rating>(
            //   firstPageKey: 0,
            //   // getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
            // );
            controller.pagingController.refresh();
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
