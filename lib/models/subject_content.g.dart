// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectContentAdapter extends TypeAdapter<SubjectContent> {
  @override
  final int typeId = 7;

  @override
  SubjectContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectContent(
      title: fields[0] as String,
      description: fields[1] as String,
      understanding: fields[2] as ContentUnderstanding,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectContent obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.understanding);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContentUnderstandingAdapter extends TypeAdapter<ContentUnderstanding> {
  @override
  final int typeId = 8;

  @override
  ContentUnderstanding read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ContentUnderstanding.lowest;
      case 1:
        return ContentUnderstanding.low;
      case 2:
        return ContentUnderstanding.normal;
      case 3:
        return ContentUnderstanding.high;
      case 4:
        return ContentUnderstanding.highest;
      default:
        return ContentUnderstanding.lowest;
    }
  }

  @override
  void write(BinaryWriter writer, ContentUnderstanding obj) {
    switch (obj) {
      case ContentUnderstanding.lowest:
        writer.writeByte(0);
        break;
      case ContentUnderstanding.low:
        writer.writeByte(1);
        break;
      case ContentUnderstanding.normal:
        writer.writeByte(2);
        break;
      case ContentUnderstanding.high:
        writer.writeByte(3);
        break;
      case ContentUnderstanding.highest:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentUnderstandingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
