import 'package:hive_flutter/hive_flutter.dart';
part 'subject_content.g.dart';

@HiveType(typeId: 8)
enum ContentUnderstanding {
  @HiveField(0)
  lowest(level: 1),

  @HiveField(1)
  low(level: 2),

  @HiveField(2)
  normal(level: 3),

  @HiveField(3)
  high(level: 4),

  @HiveField(4)
  highest(level: 5);

  final int level;
  const ContentUnderstanding({required this.level});

  bool operator >(ContentUnderstanding other) => level > other.level;
}

@HiveType(typeId: 7)
class SubjectContent {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  ContentUnderstanding understanding;

  SubjectContent(
      {this.title = "untitled",
      this.description = "",
      this.understanding = ContentUnderstanding.normal});
}
