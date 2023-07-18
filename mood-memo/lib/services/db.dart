import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'date.dart';

class DatabaseService {
  static SharedPreferences? _prefs;
  static Box? _ratingsBox;
  static Box? _notesBox;
  static List<dynamic> sortedKeys = [];

  static Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> _initBox() async {
    _ratingsBox ??= await Hive.openBox('ratings');
    _notesBox ??= await Hive.openBox('notes');
  }

  static Future<void> setRating(Rating rating) async {
    await _initBox();
    final docKey = DateService.formatDate(rating.date);
    await _ratingsBox!.put(docKey, rating.value.number);
    await _notesBox!.put(docKey, rating.note);
  }

  static Future<Rating?> getRatingFromDay(DateTime day) async {
    await _initBox();
    final docKey = DateService.formatDate(day);
    final value = _ratingsBox!.get(docKey);
    final note = _notesBox!.get(docKey);
    if (value != null) {
      return Rating(
        date: day,
        value: RatingValue.values[value],
        note: note ?? 'error',
      );
    }
    return null;
  }

  static Future<List<Rating>> getSortedRatings(int from, int to) async {
    await _initBox();
    final ratings = <Rating>[];

    // possibly add a filter option for the user to filter out empty notes
    if (from == 0) {
      sortedKeys =
          _ratingsBox!.keys //.where((element) => _notesBox!.get(element) != "")
              .toList()
            ..sort((a, b) => b.compareTo(a));
    }

    for (int i = from; i < to && i < sortedKeys.length; i++) {
      final key = sortedKeys[i];
      final value = _ratingsBox!.get(key);
      final note = _notesBox!.get(key);

      if (value != null) {
        ratings.add(Rating(
          date: DateTime.parse(key),
          value: RatingValue.values[value],
          note: note ?? 'error',
        ));
      }
    }

    return ratings;
  }

  static Future<void> deleteRating(DateTime date) async {
    await _initBox();
    final docKey = DateService.formatDate(date);
    await _ratingsBox!.delete(docKey);
    await _notesBox!.delete(docKey);
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
