import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../models/rating.dart';

class DatabaseService {
  SharedPreferences? _prefs;

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  Future<void> setRating(Rating rating) async {
    await _initPrefs();
    final docKey = formatDate(rating.timestamp);
    _prefs!.setInt('rating_$docKey', rating.number);
    _prefs!.setString('note_$docKey', rating.note);
  }

  Future<Rating?> getRatingFromDay(DateTime day) async {
    await _initPrefs();
    final docKey = formatDate(day);
    final value = _prefs!.getInt('rating_$docKey');
    final note = _prefs!.getString('note_$docKey');
    if (value != null) {
      return Rating(
        timestamp: day,
        value: RatingValue.values[value],
        note: note ?? 'There is no note for this day',
      );
    }
    return null;
  }

  Future<void> deleteRating(String date) async {
    await _initPrefs();
    final docKey = formatDate(DateTime.parse(date));
    _prefs!.remove('rating_$docKey');
    _prefs!.remove('note_$docKey');
  }
}