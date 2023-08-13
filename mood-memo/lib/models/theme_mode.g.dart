import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 1;

  @override
  ThemeMode read(BinaryReader reader) {
    final index = reader.readInt();
    return ThemeMode.values[index];
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    writer.writeInt(obj.index);
  }
}