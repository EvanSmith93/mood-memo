import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/main.dart';
import 'package:mood_log/models/rating.dart';
import 'package:mood_log/screens/detail_page.dart';
import 'package:mood_log/services/db.dart';

import '../widgets/new_rating_popup.dart';

class ColorGridController {
  Map<String, Rating> days = {};

  Future<Rating?> getRating(DateTime date) async {
    DatabaseService db = DatabaseService();
    Rating? rating = await db.getRatingFromDay(date);

    if (rating != null) {
      days[date.toString()] = rating;
      return rating;
    } else {
      if (days.containsKey(date.toString())) {
        days.remove(date.toString());
      }
      return null;
    }
  }

  void onTap(DateTime? date, Function refresher) {
    if (days.containsKey(date.toString())) {
      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                rating: days[date.toString()]!, refresher: refresher)),
      );
    } else if (!date!.isAfter(DateTime.now())) {
      showRatingPopup(refresher, date, null, null);
    }
  }
}
