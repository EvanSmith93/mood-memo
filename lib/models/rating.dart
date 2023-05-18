import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/services/db.dart';

enum RatingValue {
  none,
  one,
  two,
  three,
  four,
  five;

  int get number {
    switch (this) {
      case none:
        return -1;
      case one:
        return 1;
      case two:
        return 2;
      case three:
        return 3;
      case four:
        return 4;
      case five:
        return 5;
    }
  }

  Color get color {
    switch (this) {
      case none:
        return Colors.grey;
      case one:
        return Colors.red;
      case two:
        return Colors.orange;
      case three:
        return Colors.blue;
      case four:
        return Colors.purple;
      case five:
        return Colors.green;
    }
  }

  IconData get icon {
    switch (this) {
      case none:
        return Icons.sentiment_neutral;
      case one:
        return Icons.sentiment_very_dissatisfied;
      case two:
        return Icons.sentiment_dissatisfied;
      case three:
        return Icons.sentiment_satisfied;
      case four:
        return Icons.sentiment_satisfied_alt;
      case five:
        return Icons.sentiment_very_satisfied;
    }
  }
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
}
