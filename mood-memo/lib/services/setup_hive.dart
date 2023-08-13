import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_memo/models/settings.dart';
import 'package:mood_memo/models/theme_mode.g.dart';
import 'package:mood_memo/models/time_of_day.g.dart';

/// A service function that opens the Hive boxes and regesters type adapters.
Future<void> setupHive() async {
  await Hive.initFlutter();

  // registers the type adapters
  Hive.registerAdapter(SettingsModelAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(ThemeModeAdapter());

  // TODO: implement the ratings being stored as a rating object, rather than two separate string boxes. This will require a migration and may be too hard.
  //Hive.registerAdapter(RatingValueAdapter());
  //Hive.registerAdapter(RatingAdapter());

  // opens the boxes
  await Hive.openBox('ratings');
  await Hive.openBox('notes');
  Box settings = await Hive.openBox<SettingsModel>('settings');

  // adds default settings if they don't exist
  if (!settings.containsKey('settings')) {
    settings.put('settings', SettingsModel());
  }
}