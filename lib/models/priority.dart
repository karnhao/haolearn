import 'package:hive_flutter/hive_flutter.dart';
part 'priority.g.dart';

@HiveType(typeId: 6)
enum Priority {
  @HiveField(0)
  highest(level: 5),

  @HiveField(1)
  high(level: 4),

  @HiveField(2)
  normal(level: 3),

  @HiveField(3)
  low(level: 2),

  @HiveField(4)
  lowest(level: 1);

  final int level;
  const Priority({required this.level});

  bool operator >(Priority p) => level > p.level;
  bool operator <(Priority p) => level < p.level;
  bool operator <=(Priority p) => level <= p.level;
  bool operator >=(Priority p) => level >= p.level;

  /// level 1 = lowest
  /// level 2 = low
  /// level 3 = normal
  /// level 4 = high
  /// level 5 = highest
  /// otherwise = lowest
  static Priority from(int level) {
    switch (level) {
      case 1:
        return Priority.lowest;
      case 2:
        return Priority.low;
      case 3:
        return Priority.normal;
      case 4:
        return Priority.high;
      case 5:
        return Priority.highest;
      default:
        return Priority.lowest;
    }
  }
}
