import 'package:flutter/material.dart';
import 'package:mood_memo/services/date.dart';

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
        return Colors.black;
      case one:
        return const Color.fromARGB(255, 225, 56, 56);
      case two:
        return const Color.fromARGB(255, 222, 108, 51);
      case three:
        return const Color.fromARGB(255, 72, 101, 220);
      case four:
        return const Color.fromARGB(255, 94, 202, 62);
      case five:
        return const Color.fromARGB(255, 226, 190, 47);
    }
  }

  String get word {
    switch (this) {
      case none:
        return 'None';
      case one:
        return 'Bad';
      case two:
        return 'Not Good';
      case three:
        return 'Okay';
      case four:
        return 'Good';
      case five:
        return 'Great';
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
    return DateService.formatDate(date);
  }

  String getRelativeDate() {
    return DateService.formatRelativeDate(date);
  }
}