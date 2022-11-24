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

  /// level 1 = lowest
  /// level 2 = low
  /// level 3 = normal
  /// level 4 = high
  /// level 5 = highest
  /// otherwise = normal
  static ContentUnderstanding from(int level) {
    switch (level) {
      case 1:
        return ContentUnderstanding.lowest;
      case 2:
        return ContentUnderstanding.low;
      case 3:
        return ContentUnderstanding.normal;
      case 4:
        return ContentUnderstanding.high;
      case 5:
        return ContentUnderstanding.highest;
      default:
        return ContentUnderstanding.normal;
    }
  }

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
