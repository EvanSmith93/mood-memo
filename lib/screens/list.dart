import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mood_memo/controllers/list_controller.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/widgets/list_item.dart';

class RatingList extends StatefulWidget {
  const RatingList({super.key});

  @override
  State<RatingList> createState() => _RatingListState();
}

class _RatingListState extends State<RatingList> {
  RatingListController controller = RatingListController();

  @override
  void initState() {
    super.initState();
    controller.pagingController.addPageRequestListener((pageKey) {
      controller.fetchRatings(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Rating>.separated(
      separatorBuilder: (context, index) => const Divider(),
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Rating>(
          itemBuilder: (context, item, index) => ListTile(
                title: ListItem(rating: item, controller: controller),
                onTap: () => controller.onTap(item),
              ),
      ),
    );
  }
}
