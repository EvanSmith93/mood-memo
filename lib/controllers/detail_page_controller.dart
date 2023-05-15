import 'package:mood_log/services/db.dart';

class DetailPageController {
  DatabaseService db = DatabaseService();
  
  void deleteRating(String date, Function refresher) async {
    db.deleteRating(date);
    refresher(() {});
  }
}