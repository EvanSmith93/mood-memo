import 'package:flutter/material.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/services/db.dart';
import 'package:mood_memo/screens/edit.dart';

class DetailPageController {
  void editRating(Function refresher, Rating rating) {
    showEditPopup(refresher, rating.date, rating.value, rating.note);
  }

  void deleteRating(DateTime date, Function refresher) {
    DatabaseService.deleteRating(date);
    refresher(() {});
  }

  void showDeleteAlert(
      BuildContext context, Function refresher, Rating rating) {
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
                    deleteRating(rating.date, refresher);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete")),
            ],
          );
        });
  }
}
