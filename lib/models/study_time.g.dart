// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudyTimeAdapter extends TypeAdapter<StudyTime> {
  @override
  final int typeId = 4;

  @override
  StudyTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudyTime(
      day: fields[0] as int,
      startTime: fields[1] as int,
      width: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StudyTime obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.width);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudyTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
