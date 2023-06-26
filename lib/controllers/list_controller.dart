import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mood_memo/main.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/screens/detail.dart';
import 'package:mood_memo/services/db.dart';

class RatingListController {
  PagingController<int, Rating> pagingController =
      PagingController(firstPageKey: 0);
  int pageSize = 5;

  void fetchRatings(int pageKey) {
    DatabaseService.getSortedRatings(
            pageKey * pageSize, (pageKey + 1) * pageSize)
        .then((value) {
      value.length < pageSize
          ? pagingController.appendLastPage(value)
          : pagingController.appendPage(value, pageKey + 1);
    });
  }

  void onTap(Rating rating) {
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => Detail(
              rating: rating,
              refresher: (_) {
                pagingController.refresh();
              })),
    );
  }
}
