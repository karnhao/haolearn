import 'package:hive_flutter/hive_flutter.dart';

part 'subject_score.g.dart';

@HiveType(typeId: 9)
class SubjectScore {
  @HiveField(0)
  double score;

  @HiveField(1)
  double maxScore;

  @HiveField(2)
  String name;

  SubjectScore(
      {required this.name, required this.score, required this.maxScore});

  String getScoreAsString() {
    return "$score / $maxScore";
  }

  String getName() {
    return name;
  }
}
