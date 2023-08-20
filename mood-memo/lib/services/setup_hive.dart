import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/models/rating_value.dart';
import 'package:mood_memo/models/settings.dart';
import 'package:mood_memo/models/theme_mode.g.dart';
import 'package:mood_memo/models/time_of_day.g.dart';
import 'package:mood_memo/services/date.dart';
import 'package:path_provider/path_provider.dart';

/// A service function that moves the old Hive boxes to the new Hive directory. This function is only used once.
Future<void> moveHiveBoxes(String newPath) async {
  bool needToMove = await Hive.boxExists('ratings');
  if (needToMove) {
    Box ratings = await Hive.openBox('ratings');
    Box notes = await Hive.openBox('notes');
    Box newRatings = await Hive.openBox<Rating>('userRatings', path: newPath);

    for (String date in ratings.keys) {
      int? value = ratings.get(date);
      String? note = notes.get(date);

      if (value != null && note != null) {
        Rating rating = Rating(
          date: DateService.parseDate(date),
          value: RatingValue.values[value],
          note: note,
        );

        newRatings.put(date, rating);
      }
    }

    Hive.deleteBoxFromDisk('ratings');
    Hive.deleteBoxFromDisk('notes');

    Box settings = await Hive.openBox<SettingsModel>('settings');
    Box newSettings =
        await Hive.openBox<SettingsModel>('userSettings', path: newPath);
    newSettings.put('userSettings', settings.get('settings'));
    Hive.deleteBoxFromDisk('settings');

    await Hive.close();
  }
}

/// A service function that opens the Hive boxes and regesters type adapters.
Future<void> setupHive() async {
  await Hive.initFlutter();

  // registers the type adapters
  Hive.registerAdapter(SettingsModelAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(ThemeModeAdapter());
  Hive.registerAdapter(RatingValueAdapter());
  Hive.registerAdapter(RatingAdapter());

  // gets the path to the Hive directory
  Directory dir = await getApplicationDocumentsDirectory();
  String path = '${dir.path}/Hive';
  await Directory(path).create(recursive: true);

  // moves the old Hive boxes to the new Hive directory
  await moveHiveBoxes(path);

  // opens the Hive boxes
  await Hive.openBox<Rating>('userRatings', path: path);
  Box settings = await Hive.openBox<SettingsModel>('userSettings', path: path);

  // adds default settings if they don't exist
  if (!settings.containsKey('userSettings')) {
    settings.put('userSettings', SettingsModel());
  }
}
