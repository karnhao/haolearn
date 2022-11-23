// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 3;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subject(
      name: fields[0] as String,
    )
      ..room = fields[1] as String?
      ..teacherName = fields[2] as String?
      ..studyTimes = (fields[3] as List).cast<StudyTime>()
      ..contents = (fields[4] as List).cast<SubjectContent>()
      ..scores = (fields[5] as List).cast<SubjectScore>();
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.room)
      ..writeByte(2)
      ..write(obj.teacherName)
      ..writeByte(3)
      ..write(obj.studyTimes)
      ..writeByte(4)
      ..write(obj.contents)
      ..writeByte(5)
      ..write(obj.scores);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
