import 'package:flutter/material.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/services/db.dart';
import 'package:mood_memo/widgets/new_rating_popup.dart';

class DetailPageController {
  void editRating(Function refresher, Rating rating) {
    showRatingPopup(refresher, rating.date, rating.value, rating.note);
  }

  void deleteRating(String date, Function refresher) async {
    DatabaseService.deleteRating(date);
    refresher(() {});
  }

  Future<void> showDeleteAlert(
      BuildContext context, Function refresher, Rating rating) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Rating"),
            content: const Text("Are you sure you want to delete this rating?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    deleteRating(rating.getDate(), refresher);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete")),
            ],
          );
        });
  }
}
