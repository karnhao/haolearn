import 'package:haolearn/models/subject.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'table.g.dart';

@HiveType(typeId: 2)
class Table {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<Subject> subjectList = List.empty(growable: true);

  Table({required this.name});
}
