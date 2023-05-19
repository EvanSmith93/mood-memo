import 'package:flutter/material.dart';
import 'package:mood_log/models/rating.dart';
import 'package:mood_log/services/db.dart';

class NewRatingController {
  DatabaseService db = DatabaseService();

  DateTime selectedDate = DateTime.now();
  List<bool> selected = [false, false, false, false, false];
  TextEditingController noteController = TextEditingController();

  bool isComplete = false;

  void setValue(int index) {
    if (index < 0 || index > 4) return;
    selected = [false, false, false, false, false];
    selected[index] = true;
  }

  int getValue() {
    return selected.indexWhere((element) => element == true) + 1;
  }

  RatingValue? getRatingValue() {
    if (getValue() <= 0) return null;
    return RatingValue.values[getValue()];
  }

  bool isSelected(RatingValue value) {
    return selected[value.index - 1];
  }

  DateTime getDate() {
    return selectedDate;
  }

  void setDate(DateTime date) {
    selectedDate = date;
  }

  Future<void> updateRating(String initDate) async {
    await db.deleteRating(initDate);
    Rating rating = Rating(
        date: selectedDate,
        value: RatingValue.values[getValue()],
        note: noteController.text);
    await db.setRating(rating);
    isComplete = true;
  }
}
