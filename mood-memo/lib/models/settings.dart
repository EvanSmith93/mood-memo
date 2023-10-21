import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'color_palette.dart';

part 'settings.g.dart';

@HiveType(typeId: 2)
class SettingsModel {
  SettingsModel({
    this.reminderEnabled = false,
    this.reminderTime = const TimeOfDay(hour: 19, minute: 0),
    this.themeMode = ThemeMode.system,
    this.colorPalette = ColorPalette.classic,
  });

  @HiveField(0)
  bool reminderEnabled;

  @HiveField(1)
  TimeOfDay reminderTime;

  @HiveField(2)
  ThemeMode themeMode;

  @HiveField(3)
  ColorPalette colorPalette;
}