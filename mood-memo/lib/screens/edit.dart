import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mood_memo/controllers/edit_controller.dart';
import 'package:mood_memo/main.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/widgets/edit/edit_rating.dart';

void showEditPopup(
    Function refresher, DateTime? date, RatingValue? rating, String? note) {
  NewRatingController controller = NewRatingController();

  if (date != null) controller.setDate(date);
  if (rating != null) controller.selected[rating.index - 1] = true;
  if (note != null) controller.noteController.text = note;

  showEditPopupHelper(controller, refresher, date, rating, note);
}

void showEditPopupHelper(NewRatingController controller, Function refresher,
    DateTime? date, RatingValue? rating, String? note) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    context: navigatorKey.currentContext!,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            var focusScope = FocusScope.of(context);
            if (!focusScope.hasPrimaryFocus) focusScope.unfocus();
          },
          child: SingleChildScrollView(
            controller: ModalScrollController.of(context),
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: EditRating(
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
        if (controller.noteController.text != (note ?? '') &&
            controller.isComplete == false)
          {controller.showUnsavedAlert(refresher, date, rating, note)}
      });
}
