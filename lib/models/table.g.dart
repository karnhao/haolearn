// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableAdapter extends TypeAdapter<Table> {
  @override
  final int typeId = 2;

  @override
  Table read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Table(
      name: fields[0] as String,
    )..subjectList = (fields[1] as List).cast<Subject>();
  }

  @override
  void write(BinaryWriter writer, Table obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.subjectList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
