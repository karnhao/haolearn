// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_score.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectScoreAdapter extends TypeAdapter<SubjectScore> {
  @override
  final int typeId = 9;

  @override
  SubjectScore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectScore(
      name: fields[2] as String,
      score: fields[0] as double,
      maxScore: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectScore obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.score)
      ..writeByte(1)
      ..write(obj.maxScore)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectScoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
