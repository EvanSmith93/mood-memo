import 'package:flutter/material.dart';
import 'package:mood_memo/main.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/models/rating_value.dart';
import 'package:mood_memo/services/db.dart';
import 'package:mood_memo/screens/edit.dart';

class NewRatingController {
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

  void updateRating(DateTime? initDate) {
    if (initDate != null && initDate != getDate())
      DatabaseService.deleteRating(initDate);

    Rating rating = Rating(
        date: selectedDate,
        value: RatingValue.values[getValue()],
        note: noteController.text);
    DatabaseService.setRating(rating);
    isComplete = true;
  }

  void showUnsavedAlert(
      Function refresher, DateTime? date, RatingValue? rating, String? note) {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
              title: const Text('Discard changes?'),
              content: const Text(
                  'You have unsaved changes. Are you sure you want to discard them?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Discard')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showEditPopupHelper(this, refresher, date, rating, note);
                    },
                    child: const Text('Keep Editing')),
              ],
            ));
  }

  void saveRating(DateTime? initDate, Function refresher) {
    void saveRating() {
      updateRating(initDate);
      Navigator.pop(navigatorKey.currentContext!);
      refresher(() {});
    }

    if (initDate != getDate() &&
        DatabaseService.getRatingFromDay(getDate()) != null) {
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
                title: const Text('Overwrite rating?'),
                content: const Text(
                    'You have already rated this day. Are you sure you want to overwrite your previous rating?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        saveRating();
                      },
                      child: const Text('Overwrite')),
                ],
              ));
    } else {
      saveRating();
    }
  }
}
