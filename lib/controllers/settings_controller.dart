import 'package:flutter/material.dart';
import 'package:mood_log/main.dart';
import 'package:mood_log/services/db.dart';

class SettingsController extends ChangeNotifier {
  DatabaseService db = DatabaseService();

  static ThemeMode theme = ThemeMode.system;

  static Future<void> initializeTheme() async {
    theme = await DatabaseService.getThemeMode();
    await setTheme(theme);
  }

  String get themeName {
    switch (theme) {
      case ThemeMode.system:
        return 'System Default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'System Default';
    }
  }

  static Future<void> setTheme(ThemeMode mode) async {
    MyApp.themeMode.value = mode;
    theme = mode;
    await DatabaseService.setThemeMode(mode);
  }
}
