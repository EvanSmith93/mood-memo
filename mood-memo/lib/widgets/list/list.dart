import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mood_memo/controllers/list_controller.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/widgets/list/list_item.dart';

class RatingList extends StatefulWidget {
  final RatingListController controller;
  const RatingList({super.key, required this.controller});

  @override
  State<RatingList> createState() => _RatingListState();
}

class _RatingListState extends State<RatingList> {
  @override
  void initState() {
    super.initState();
    widget.controller.pagingController.addPageRequestListener((pageKey) {
      widget.controller.fetchRatings(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Rating>.separated(
      separatorBuilder: (context, index) => const Divider(),
      pagingController: widget.controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Rating>(
        // the builder for when the user has no ratings
        noItemsFoundIndicatorBuilder: (context) => const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You don't have any ratings yet.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Tap the new rating button to add one.",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        // the standard builder for the ratings
        itemBuilder: (context, item, index) => ListTile(
          title: ListItem(rating: item, controller: widget.controller),
          onTap: () => widget.controller.onTap(item),
        ),
      ),
    );
  }
}
