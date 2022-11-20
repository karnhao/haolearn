// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriorityAdapter extends TypeAdapter<Priority> {
  @override
  final int typeId = 6;

  @override
  Priority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Priority.highest;
      case 1:
        return Priority.high;
      case 2:
        return Priority.normal;
      case 3:
        return Priority.low;
      case 4:
        return Priority.lowest;
      default:
        return Priority.highest;
    }
  }

  @override
  void write(BinaryWriter writer, Priority obj) {
    switch (obj) {
      case Priority.highest:
        writer.writeByte(0);
        break;
      case Priority.high:
        writer.writeByte(1);
        break;
      case Priority.normal:
        writer.writeByte(2);
        break;
      case Priority.low:
        writer.writeByte(3);
        break;
      case Priority.lowest:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
