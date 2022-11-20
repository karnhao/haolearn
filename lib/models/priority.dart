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
}
