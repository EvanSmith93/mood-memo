import 'package:flutter/material.dart';

/// extension of theme mode
extension ThemeModeExtension on ThemeMode {
  /// returns the name of the theme mode
  String get prettyName {
    switch (this) {
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
}