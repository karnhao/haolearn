import 'package:haolearn/models/table.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'save.g.dart';

@HiveType(typeId: 1)
class Save extends HiveObject {
  @HiveField(0)
  bool first = true;

  @HiveField(1)
  List<Table> tables;

  @HiveField(2)
  Table mainTable;

  Save({required this.tables, required this.mainTable});

  void addTable(Table table) {
    tables.add(table);
  }

  void removeTable(int index) {
    tables.removeAt(index);
  }

  Table? getMainTable() {
    return mainTable;
  }
}
// flutter packages pub run build_runner build