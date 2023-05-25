import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:mood_log/models/rating.dart';

class DatabaseService {
  static SharedPreferences? _prefs;

  static Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  DatabaseService() {
    _initPrefs();

  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  String prettyFormatDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEEE, MMMM d, yyyy');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  Future<void> setRating(Rating rating) async {
    await _initPrefs();
    final docKey = formatDate(rating.date);
    _prefs!.setInt('rating_$docKey', rating.value.number);
    _prefs!.setString('note_$docKey', rating.note);
  }

  Future<Rating?> getRatingFromDay(DateTime day) async {
    await _initPrefs();
    final docKey = formatDate(day);
    final value = _prefs!.getInt('rating_$docKey');
    final note = _prefs!.getString('note_$docKey');
    if (value != null) {
      return Rating(
        date: day,
        value: RatingValue.values[value],
        note: note ?? '',
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

  static Future<ThemeMode> getThemeMode() async {
    await _initPrefs();
    final themeMode = _prefs!.getInt('theme_mode');
    return themeMode != null ? ThemeMode.values[themeMode] : ThemeMode.system;
  }
  
  static Future<void> setThemeMode(ThemeMode mode) async {
    await _initPrefs();
    _prefs!.setInt('theme_mode', mode.index);
  }
}