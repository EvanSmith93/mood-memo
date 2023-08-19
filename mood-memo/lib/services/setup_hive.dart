import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_memo/models/rating.dart';
import 'package:mood_memo/models/rating_value.dart';
import 'package:mood_memo/models/settings.dart';
import 'package:mood_memo/models/theme_mode.g.dart';
import 'package:mood_memo/models/time_of_day.g.dart';
import 'package:mood_memo/services/date.dart';
import 'package:path_provider/path_provider.dart';

Future<void> moveHiveBoxes(String newPath) async {
  bool needToMove = await Hive.boxExists('ratings');
  if (needToMove) {
    print('moving hive boxes');

    Box ratings = await Hive.openBox('ratings');
    Box notes = await Hive.openBox('notes');
    Box newRatings = await Hive.openBox<Rating>('ratings', path: newPath);

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
        await Hive.openBox<SettingsModel>('settings', path: newPath);
    newSettings.put('settings', settings.get('settings'));
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

  // opens the boxes
  Directory dir = await getApplicationDocumentsDirectory();
  print('dir ${dir.path}');
  String path = '${dir.path}/Hive';
  await Directory(path).create(recursive: true);
  
  moveHiveBoxes(path);

  Box ratings = await Hive.openBox<Rating>('ratings', path: path);
  Box settings = await Hive.openBox<SettingsModel>('settings', path: path);

  // adds default settings if they don't exist
  if (!settings.containsKey('settings')) {
    settings.put('settings', SettingsModel());
  }

  // try to restore the backup if the ratings and notes are empty
  /*if (ratings.isEmpty && notes.isEmpty) {
    try {
      await restoreHiveBox('ratings');
      await restoreHiveBox('notes');
    } catch (e) {
      print(e);
    }
  }*/
}
