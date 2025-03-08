import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mood_memo/main.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/screens/detail.dart';
import 'package:mood_memo/services/db.dart';

class RatingListController {
  static int pageSize = 10;

  PagingController<int, Rating> pagingController = PagingController(
    getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    fetchPage: (pageKey) {
      return DatabaseService.getSortedRatings(
          pageKey * pageSize, (pageKey + 1) * pageSize);
    },
  );

  List<Rating> fetchRatings(int pageKey) {
    final List<Rating> ratings = DatabaseService.getSortedRatings(
        pageKey * pageSize, (pageKey + 1) * pageSize);
    return ratings;
    // ratings.length < pageSize
    //     ? pagingController.appendLastPage(ratings)
    //     : pagingController.appendPage(ratings, pageKey + 1);
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
