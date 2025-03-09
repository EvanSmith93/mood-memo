// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_palette.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColorPaletteAdapter extends TypeAdapter<ColorPalette> {
  @override
  final int typeId = 5;

  @override
  ColorPalette read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ColorPalette.classic;
      case 1:
        return ColorPalette.light;
      case 2:
        return ColorPalette.dark;
      case 3:
        return ColorPalette.red;
      case 4:
        return ColorPalette.orange;
      case 5:
        return ColorPalette.green;
      case 6:
        return ColorPalette.blue;
      case 7:
        return ColorPalette.purple;
      default:
        return ColorPalette.classic;
    }
  }

  @override
  void write(BinaryWriter writer, ColorPalette obj) {
    switch (obj) {
      case ColorPalette.classic:
        writer.writeByte(0);
        break;
      case ColorPalette.light:
        writer.writeByte(1);
        break;
      case ColorPalette.dark:
        writer.writeByte(2);
        break;
      case ColorPalette.red:
        writer.writeByte(3);
        break;
      case ColorPalette.orange:
        writer.writeByte(4);
        break;
      case ColorPalette.green:
        writer.writeByte(5);
        break;
      case ColorPalette.blue:
        writer.writeByte(6);
        break;
      case ColorPalette.purple:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorPaletteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
