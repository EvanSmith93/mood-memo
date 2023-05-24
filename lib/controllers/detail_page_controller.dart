import 'package:mood_log/models/rating.dart';
import 'package:mood_log/services/db.dart';
import 'package:mood_log/widgets/new_rating_popup.dart';

class DetailPageController {
  DatabaseService db = DatabaseService();

  void editRating(Function refresher, Rating rating) {
    showRatingPopup(refresher, rating.date, rating.value, rating.note);
  }

  void deleteRating(String date, Function refresher) async {
    db.deleteRating(date);
    refresher(() {});
  }
}
