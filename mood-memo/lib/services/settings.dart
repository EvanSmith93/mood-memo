import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mood_memo/models/settings.dart';

class SettingsService {
  static final Box<SettingsModel> _settingsBox =
      Hive.box<SettingsModel>('settings');

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
