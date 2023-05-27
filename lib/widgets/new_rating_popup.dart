import 'package:flutter/material.dart';
import 'package:mood_log/controllers/new_rating_controller.dart';
import 'package:mood_log/main.dart';
import 'package:mood_log/models/rating.dart';
import 'package:mood_log/widgets/new_rating.dart';

void showRatingPopup(Function refresher, DateTime? date, RatingValue? rating, String? note) {
  NewRatingController controller = NewRatingController();
  
  if (date != null) controller.setDate(date);
  if (rating != null) controller.selected[rating.index - 1] = true;
  if (note != null) controller.noteController.text = note;

  showRatingPopupHelper(controller, refresher, date, rating, note);
}

void showRatingPopupHelper(NewRatingController controller, Function refresher, DateTime? date, RatingValue? rating, String? note) {
  showModalBottomSheet(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
  isScrollControlled: true,
  isDismissible: true,
  context: navigatorKey.currentContext!,
  builder: (context) {
    return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: (MediaQuery.of(context).size.height * 0.94) - MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: NewRating(
                controller: controller,
                refresher: refresher,
                date: date,
                rating: rating,
                note: note,
              ),
            ),
          ),
    );
  },
).whenComplete(() => {
        if (controller.noteController.text != (note ?? '') && controller.isComplete == false) {
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
                              showRatingPopupHelper(controller, refresher, date, rating, note);
                            },
                            child: const Text('Keep Editing')),
                      ],
                    ))
          }
      });
}
