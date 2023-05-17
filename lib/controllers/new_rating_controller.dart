import 'package:mood_log/models/rating.dart';
import 'package:mood_log/services/db.dart';

class RateDayController {
  DatabaseService db = DatabaseService();

  DateTime selectedDate = DateTime.now();
  List<bool> selected = [false, false, false, false, false];
  String note = "";
  
  RateDayController({DateTime? date}) {
    if (date != null) {
      selectedDate = date;
    }
  }

  int getValue() {
    return selected.indexWhere((element) => element == true) + 1;
  }

  void setNote(String note) {
    this.note = note;
  }

  void setTimestamp(DateTime date) {
    selectedDate = date;
  }

  Future<void> setRating() async {
    Rating rating =
        Rating(date: selectedDate, value: RatingValue.values[getValue()], note: note);
    
    await db.setRating(rating);
  }
}
