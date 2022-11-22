// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveAdapter extends TypeAdapter<Save> {
  @override
  final int typeId = 1;

  @override
  Save read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Save(
      mainTable: fields[1] as Table,
    )
      ..first = fields[0] as bool
      ..tasks = (fields[2] as List).cast<Task>();
  }

  @override
  void write(BinaryWriter writer, Save obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.first)
      ..writeByte(1)
      ..write(obj.mainTable)
      ..writeByte(2)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
