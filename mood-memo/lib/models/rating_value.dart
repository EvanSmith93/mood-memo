import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mood_memo/services/settings.dart';

part 'rating_value.g.dart';

@HiveType(typeId: 3)
enum RatingValue {
  @HiveField(0)
  none,
  @HiveField(1)
  one,
  @HiveField(2)
  two,
  @HiveField(3)
  three,
  @HiveField(4)
  four,
  @HiveField(5)
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
    int index = number - 1;
    if (index < 0) {
      return Colors.black;
    } else {
      return SettingsService.getColorPalette().colors[index];
    }
  }

  String get word {
    switch (this) {
      case none:
        return 'None';
      case one:
        return 'Very Unpleasant';
      case two:
        return 'Unpleasant';
      case three:
        return 'Neutral';
      case four:
        return 'Pleasant';
      case five:
        return 'Very Pleasant';
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