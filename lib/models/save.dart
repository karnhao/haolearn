import 'package:haolearn/models/table.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'save.g.dart';

@HiveType(typeId: 1)
class Save extends HiveObject {
  @HiveField(0)
  bool first = true;

  @HiveField(1)
  Table table;

  Save({required this.table});
}
