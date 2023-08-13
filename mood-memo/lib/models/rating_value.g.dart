// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_value.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RatingValueAdapter extends TypeAdapter<RatingValue> {
  @override
  final int typeId = 3;

  @override
  RatingValue read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RatingValue.none;
      case 1:
        return RatingValue.one;
      case 2:
        return RatingValue.two;
      case 3:
        return RatingValue.three;
      case 4:
        return RatingValue.four;
      case 5:
        return RatingValue.five;
      default:
        return RatingValue.none;
    }
  }

  @override
  void write(BinaryWriter writer, RatingValue obj) {
    switch (obj) {
      case RatingValue.none:
        writer.writeByte(0);
        break;
      case RatingValue.one:
        writer.writeByte(1);
        break;
      case RatingValue.two:
        writer.writeByte(2);
        break;
      case RatingValue.three:
        writer.writeByte(3);
        break;
      case RatingValue.four:
        writer.writeByte(4);
        break;
      case RatingValue.five:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
