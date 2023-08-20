import 'package:mood_memo/models/rating.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_memo/services/date.dart';

class DatabaseService {
  static Box get _ratingsBox => Hive.box<Rating>('userRatings');
  static List<dynamic> sortedKeys = [];

  static void setRating(Rating rating) {
    final docKey = DateService.formatDate(rating.date);
    _ratingsBox.put(docKey, rating);
  }

  static Rating? getRatingFromDay(DateTime day) {
    final docKey = DateService.formatDate(day);
    return _ratingsBox.get(docKey);
  }

  static List<Rating> getSortedRatings(int from, int to) {
    final ratings = <Rating>[];

    // possibly add a filter option for the user to filter out empty notes
    if (from == 0) {
      sortedKeys =
          _ratingsBox.keys //.where((element) => _notesBox!.get(element) != "")
              .toList()
            ..sort((a, b) => b.compareTo(a));
    }

    for (int i = from; i < to && i < sortedKeys.length; i++) {
      final key = sortedKeys[i];
      ratings.add(_ratingsBox.get(key));
    }

    return ratings;
  }

  static void deleteRating(DateTime date) {
    final docKey = DateService.formatDate(date);
    _ratingsBox.delete(docKey);
  }

  static List<List<String>> getRatingTable() {
    final table = <List<String>>[];

    table.add(['Date', 'Rating', 'Note']);
    for (String date in _ratingsBox.keys) {
      final Rating rating = _ratingsBox.get(date);

      table.add([date, rating.value.number.toString(), rating.note]);
    }

    return table;
  }
}
