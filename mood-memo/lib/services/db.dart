import 'package:mood_memo/models/rating.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_memo/models/rating_value.dart';
import 'package:mood_memo/services/date.dart';

class DatabaseService {
  static Box get _ratingsBox => Hive.box<Rating>('ratings');
  //static Box get _notesBox => Hive.box('notes');
  static List<dynamic> sortedKeys = [];

  static void setRating(Rating rating) {
    final docKey = DateService.formatDate(rating.date);
    _ratingsBox.put(docKey, rating);
    //_notesBox.put(docKey, rating.note);
  }

  static Rating? getRatingFromDay(DateTime day) {
    final docKey = DateService.formatDate(day);
    return _ratingsBox.get(docKey);
    // final note = _notesBox.get(docKey);
    // if (value != null) {
    //   return Rating(
    //     date: day,
    //     value: RatingValue.values[value],
    //     note: note ?? 'error',
    //   );
    // }
    // return null;
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
      // final note = _notesBox.get(key);

      // if (value != null) {
      //   ratings.add(Rating(
      //     date: DateTime.parse(key),
      //     value: RatingValue.values[value],
      //     note: note ?? 'error',
      //   ));
      // }
    }

    return ratings;
  }

  static void deleteRating(DateTime date) {
    final docKey = DateService.formatDate(date);
    _ratingsBox.delete(docKey);
    //_notesBox.delete(docKey);
  }
}
