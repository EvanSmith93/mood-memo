import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/main.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/screens/detail.dart';
import 'package:mood_memo/services/db.dart';

import '../screens/edit.dart';

class ColorGridController {
  Map<String, Rating> days = {};

  Rating? getRating(DateTime date) {
    Rating? rating = DatabaseService.getRatingFromDay(date);

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
            builder: (context) =>
                Detail(rating: days[date.toString()]!, refresher: refresher)),
      );
    } else {
      showEditPopup(refresher, date, null, null);
    }
  }
}
