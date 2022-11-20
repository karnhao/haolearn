enum Priority {
  highest(level: 5),
  high(level: 4),
  normal(level: 3),
  low(level: 2),
  lowest(level: 1);

  final int level;
  const Priority({required this.level});

  bool operator >(Priority p) => level > p.level;
  bool operator <(Priority p) => level < p.level;
  bool operator <=(Priority p) => level <= p.level;
  bool operator >=(Priority p) => level >= p.level;
}
