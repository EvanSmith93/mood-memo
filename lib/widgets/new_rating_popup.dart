import 'package:flutter/material.dart';
import 'package:mood_log/widgets/new_rating.dart';

void showRatingPopup(BuildContext context, Function refresher, DateTime? date) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    isScrollControlled: true,
    context: context,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
          child: NewRating(
              refresher: refresher,
              date: date)),
    ),
  );
}