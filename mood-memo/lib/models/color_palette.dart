import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'color_palette.g.dart';

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
  yellow,
  @HiveField(6)
  green,
  @HiveField(7)
  blue,
  @HiveField(8)
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
        return [
          const Color(0xff651E1E), // not verified
          const Color(0xff8F1E1E),
          const Color(0xffB81E1E),
          const Color(0xffE11E1E),
          const Color(0xffE86464),
        ];
      case orange:
        return [
          const Color(0xff65321E), // not verified
          const Color(0xff8F4E1E),
          const Color(0xffB86B1E),
          const Color(0xffE1871E),
          const Color(0xffE8A364),
        ];
      case yellow:
        return [
          const Color(0xff65651E), // not verified (also maybe not a good color)
          const Color(0xff8F8F1E),
          const Color(0xffB8B81E),
          const Color(0xffE1E11E),
          const Color(0xffE8E864),
        ];
      case green:
        return [
          const Color(0xff326521),
          const Color(0xff4E883F),
          const Color(0xff6BAB5D),
          const Color(0xff87CD7B),
          const Color(0xffA3F099),
        ];
      case blue:
        return [
          const Color(0xff214B65),
          const Color(0xff3F6988),
          const Color(0xff5D87AB),
          const Color(0xff7BA5CD),
          const Color(0xff99C3F0),
        ];
      case purple:
        return [
          const Color(0xff4D2B83),
          const Color(0xff6B479E),
          const Color(0xff8A62BA),
          const Color(0xffA87ED5),
          const Color(0xffC699F0),
        ];
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
      case yellow:
        return 'Yellow';
      case green:
        return 'Green';
      case blue:
        return 'Blue';
      case purple:
        return 'Purple';
    }
  }
}
