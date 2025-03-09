import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'color_palette.g.dart';

List<Color> generateColorShades({
  double hue = 140,
  double saturation = 1,
  List<double> lightnessValues = const [0.18, 0.3, 0.5, 0.7, 0.82],
}) {
  List<Color> colors = [];

  for (double lightness in lightnessValues) {
    colors.add(HSLColor.fromAHSL(1, hue, saturation, lightness).toColor());
  }

  return colors;
}

@HiveType(typeId: 5)
enum ColorPalette {
  @HiveField(0)
  classic,
  @HiveField(1)
  light,
  @HiveField(2)
  dark,
  @HiveField(3)
  red,
  @HiveField(4)
  orange,
  @HiveField(5)
  green,
  @HiveField(6)
  blue,
  @HiveField(7)
  purple;

  // reutrn a list of colors based on the color palette
  List<Color> get colors {
    switch (this) {
      case classic:
        return [
          const Color(0xffe13838), // 0
          const Color(0xffe17938), // 23
          const Color(0xff3876e1), // 218
          const Color(0xff38e154), // 130
          const Color(0xffe1d338), // 55
        ];
      case light:
        return [
          const Color(0xffe86464),
          const Color(0xffe89764),
          const Color(0xff6494e8),
          const Color(0xff64e87a),
          const Color(0xffe8dd64),
        ];
      case dark:
        return [
          const Color(0xffc71e1e),
          const Color(0xffc75f1e),
          const Color(0xff1e5cc7),
          const Color(0xff1ec73a),
          const Color(0xffc7b91e),
        ];
      case red:
        return generateColorShades(hue: 350, saturation: 0.9);
      case orange:
        return generateColorShades(hue: 25, saturation: 0.9);
      case green:
        return generateColorShades(hue: 140, saturation: 0.9);
      case blue:
        return generateColorShades(hue: 205, saturation: 0.9);
      case purple:
        return generateColorShades(hue: 270, saturation: 0.9);
    }
  }

  String get name {
    switch (this) {
      case classic:
        return 'Classic';
      case light:
        return 'Light';
      case dark:
        return 'Dark';
      case red:
        return 'Red';
      case orange:
        return 'Orange';
      case green:
        return 'Green';
      case blue:
        return 'Blue';
      case purple:
        return 'Purple';
    }
  }
}
