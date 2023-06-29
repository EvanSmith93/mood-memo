import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mood_memo/controllers/list_controller.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/widgets/list_item.dart';

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
          itemBuilder: (context, item, index) => ListTile(
                title: ListItem(rating: item, controller: widget.controller),
                onTap: () => widget.controller.onTap(item),
              ),
      ),
    );
  }
}
