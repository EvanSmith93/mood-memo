import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mood_memo/models/color_palette.dart';
import 'package:mood_memo/models/settings.dart';

class SettingsService {
  static final Box<SettingsModel> _settingsBox =
      Hive.box<SettingsModel>('userSettings');

  static bool getReminderEnabled() {
    SettingsModel settings = _settingsBox.get('userSettings')!;
    return settings.reminderEnabled;
  }

  static void setReminderEnabled(bool enabled) {
    SettingsModel settings = _settingsBox.get('userSettings')!;
    settings.reminderEnabled = enabled;
    _settingsBox.put('userSettings', settings);
  }

  static TimeOfDay getReminderTime() {
    SettingsModel settings = _settingsBox.get('userSettings')!;
    return settings.reminderTime;
  }

  static void setReminderTime(TimeOfDay time) {
    SettingsModel settings = _settingsBox.get('userSettings')!;
    settings.reminderTime = time;
    _settingsBox.put('userSettings', settings);
  }

  static ThemeMode getThemeMode() {
    SettingsModel settings = _settingsBox.get('userSettings')!;
    return settings.themeMode;
  }

  static void setThemeMode(ThemeMode mode) {
    SettingsModel settings = _settingsBox.get('userSettings')!;
    settings.themeMode = mode;
    _settingsBox.put('userSettings', settings);
  }

  static ColorPalette getColorPalette() {
    SettingsModel settings = _settingsBox.get('userSettings')!;
    return settings.colorPalette;
  }

  static void setColorPalette(ColorPalette palette) {
    SettingsModel settings = _settingsBox.get('userSettings')!;
    settings.colorPalette = palette;
    _settingsBox.put('userSettings', settings);
  }
}
