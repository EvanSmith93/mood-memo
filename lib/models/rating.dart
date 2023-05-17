import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/services/db.dart';

enum RatingValue {
  none,
  one,
  two,
  three,
  four,
  five,
}

class Rating {
  late DateTime date;
  late RatingValue value;
  late String note;

  Rating({required this.date, required this.value, required this.note});

  String getDate() {
    return DatabaseService().formatDate(date);
  }

  String getPrettyDate() {
    return DatabaseService().prettyFormatDate(date);
  }

  // should include the note
  Rating.fromJson(Map<String, dynamic> json)
      : value = RatingValue.values[json['value']],
        date = DateTime.parse(json['date']);

  // should also include the note
  Map<String, dynamic> toJson() {
    return {
      'value': value.index,
      'date': date.toString(),
    };
  }

  Color get color {
    switch (value) {
      case RatingValue.none:
        return Colors.grey;
      case RatingValue.one:
        return Colors.red;
      case RatingValue.two:
        return Colors.orange;
      case RatingValue.three:
        return Colors.blue;
      case RatingValue.four:
        return Colors.purple;
      case RatingValue.five:
        return Colors.green;
    }
  }

  IconData get icon {
    switch (value) {
      case RatingValue.none:
        return Icons.sentiment_neutral;
      case RatingValue.one:
        return Icons.sentiment_very_dissatisfied;
      case RatingValue.two:
        return Icons.sentiment_dissatisfied;
      case RatingValue.three:
        return Icons.sentiment_satisfied;
      case RatingValue.four:
        return Icons.sentiment_satisfied_alt;
      case RatingValue.five:
        return Icons.sentiment_very_satisfied;
    }
  }

  int get number {
    switch (value) {
      case RatingValue.none:
        return -1;
      case RatingValue.one:
        return 1;
      case RatingValue.two:
        return 2;
      case RatingValue.three:
        return 3;
      case RatingValue.four:
        return 4;
      case RatingValue.five:
        return 5;
    }
  }
}
