import 'package:haolearn/models/notification_model.dart';
import 'package:haolearn/models/table.dart';
import 'package:haolearn/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'save.g.dart';

@HiveType(typeId: 1)
class Save extends HiveObject {
  @HiveField(0)
  bool first = true;

  @HiveField(1)
  Table mainTable;

  @HiveField(2)
  List<Task> tasks = List.empty(growable: true);

  Save({required this.mainTable});

  Table? getMainTable() {
    return mainTable;
  }

  List<Task> getTaskList() {
    return tasks;
  }

  /// จัดเรียงงานโดยจะขึ้นอยู่กับเวลาการกำหนดส่ง และความสำคัญ(Priority) ของงาน
  /// ฟังก์ชันนี้เป็น synconize
  void sortTasksFromDueDate() {
    List<Task> result = List.empty(growable: true);
    final tempHasDueDate =
        tasks.where((t) => t.dueDate != null).toList(growable: true);
    final tempNotHasDueDate =
        tasks.where((t) => t.dueDate == null).toList(growable: true);

    tempHasDueDate.sort((a, b) => b.dueDate!.millisecondsSinceEpoch
        .compareTo(a.dueDate!.millisecondsSinceEpoch));
    tempNotHasDueDate
        .sort((a, b) => a.priority.level.compareTo(b.priority.level));

    result.addAll(tempHasDueDate);
    result.addAll(tempNotHasDueDate);

    tasks = result;
  }
}
// flutter packages pub run build_runner build