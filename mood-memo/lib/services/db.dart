import 'package:flutter/material.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_memo/models/rating_value.dart';
import 'package:mood_memo/models/settings.dart';
import 'package:mood_memo/models/theme_mode.g.dart';
import 'package:mood_memo/models/time_of_day.g.dart';

import 'date.dart';

/// A service function that opens the Hive boxes. TODO: move this somewhere else
Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(SettingsModelAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(ThemeModeAdapter());
  Hive.registerAdapter(RatingValueAdapter());
  Hive.registerAdapter(RatingAdapter());

  await Hive.openBox('ratings');
  await Hive.openBox('notes');
  Box settings = await Hive.openBox<SettingsModel>('settings');

  if (!settings.containsKey('settings')) {
    settings.put('settings', SettingsModel());
  }
}

class DatabaseService {
  static Box<SettingsModel> get _settingsBox =>
      Hive.box<SettingsModel>('settings');

  static final Box _ratingsBox = Hive.box('ratings');
  static final Box _notesBox = Hive.box('notes');
  static List<dynamic> sortedKeys = [];

  static void setRating(Rating rating) {
    final docKey = DateService.formatDate(rating.date);
    _ratingsBox.put(docKey, rating.value.number);
    _notesBox.put(docKey, rating.note);
  }

  static Rating? getRatingFromDay(DateTime day) {
    final docKey = DateService.formatDate(day);
    final value = _ratingsBox.get(docKey);
    final note = _notesBox.get(docKey);
    if (value != null) {
      return Rating(
        date: day,
        value: RatingValue.values[value],
        note: note ?? 'error',
      );
    }
    return null;
  }

  static List<Rating> getSortedRatings(int from, int to) {
    final ratings = <Rating>[];

    // possibly add a filter option for the user to filter out empty notes
    if (from == 0) {
      sortedKeys =
          _ratingsBox.keys //.where((element) => _notesBox!.get(element) != "")
              .toList()
            ..sort((a, b) => b.compareTo(a));
    }

    for (int i = from; i < to && i < sortedKeys.length; i++) {
      final key = sortedKeys[i];
      final value = _ratingsBox.get(key);
      final note = _notesBox.get(key);

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

  static void deleteRating(DateTime date) {
    final docKey = DateService.formatDate(date);
    _ratingsBox.delete(docKey);
    _notesBox.delete(docKey);
  }

  // Settings TODO: move to new class

  static bool getReminderEnabled() {
    SettingsModel settings = _settingsBox.get('settings')!;
    return settings.reminderEnabled;
  }

  static void setReminderEnabled(bool enabled) {
    SettingsModel settings = _settingsBox.get('settings')!;
    settings.reminderEnabled = enabled;
    _settingsBox.put('settings', settings);
  }

  static TimeOfDay getReminderTime() {
    SettingsModel settings = _settingsBox.get('settings')!;
    return settings.reminderTime;
  }

  static void setReminderTime(TimeOfDay time) {
    SettingsModel settings = _settingsBox.get('settings')!;
    settings.reminderTime = time;
    _settingsBox.put('settings', settings);
  }

  static ThemeMode getThemeMode() {
    SettingsModel settings = _settingsBox.get('settings')!;
    return settings.themeMode;
  }

  static void setThemeMode(ThemeMode mode) {
    SettingsModel settings = _settingsBox.get('settings')!;
    settings.themeMode = mode;
    _settingsBox.put('settings', settings);
  }
}
