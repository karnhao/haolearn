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
    final tempHasDueDate = tasks
        .where((t) => t.dueDate != null && !t.complete)
        .toList(growable: true);
    final tempNotHasDueDate = tasks
        .where((t) => t.dueDate == null && !t.complete)
        .toList(growable: true);

    final tempComplete = tasks.where((t) => t.complete).toList();

    tempHasDueDate.sort((b, a) => b.dueDate!.millisecondsSinceEpoch
        .compareTo(a.dueDate!.millisecondsSinceEpoch));
    tempNotHasDueDate
        .sort((b, a) => a.priority.level.compareTo(b.priority.level));
    tempComplete.sort((b, a) => a.priority.level.compareTo(b.priority.level));

    result.addAll(tempHasDueDate);
    result.addAll(tempNotHasDueDate);
    result.addAll(tempComplete);

    tasks = result;
  }

  double getTaskCompletePercentage() {
    int finishCount = 0;
    for (var element in tasks) {
      if (element.complete) {
        finishCount++;
      }
    }
    return finishCount / tasks.length * 100;
  }

  void sortTasksFromPriority() {
    List<Task> result = List.empty(growable: true);
    final temp = tasks.where((t) => !t.complete).toList();
    final tempComplete = tasks.where((t) => t.complete).toList();
    temp.sort((b, a) => a.priority.level.compareTo(b.priority.level));
    tempComplete.sort((b, a) => a.priority.level.compareTo(b.priority.level));

    result.addAll(temp);
    result.addAll(tempComplete);

    tasks = result;
  }
}
// flutter packages pub run build_runner build