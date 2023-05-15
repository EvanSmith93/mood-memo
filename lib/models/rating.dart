import 'dart:convert';

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
  late DateTime timestamp;
  late RatingValue value;
  late String note;

  Rating({required this.timestamp, required this.value, required this.note});

  String getDate() {
    return DatabaseService().formatDate(timestamp);
  }

  // should include the note
  Rating.fromJson(Map<String, dynamic> json)
      : value = RatingValue.values[json['value']],
        timestamp = DateTime.parse(json['timestamp']);

  // should also include the note
  Map<String, dynamic> toJson() {
    return {
      'value': value.index,
      'timestamp': timestamp.toString(),
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
        return Colors.yellow;
      case RatingValue.five:
        return Colors.green;
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
