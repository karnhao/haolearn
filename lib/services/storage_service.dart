import 'dart:developer';

import 'package:haolearn/models/priority.dart';
import 'package:haolearn/models/save.dart';
import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/models/subject.dart';
import 'package:haolearn/models/subject_content.dart';
import 'package:haolearn/models/subject_score.dart';
import 'package:haolearn/models/table.dart';
import 'package:haolearn/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// ตัวช่วยในการจัดการข้อมูลที่บันทึกไว้บนเครื่อง
///
/// ใช้เรียกใช้ `StorageService.initialize()` ก่อนใช้งาน
///
/// หลักจาก initialize เสร็จ รับตัว Service ด้วยคำสั่ง `StorageService.getService()`
///
/// ระวัง : initialize เป็น async function
class StorageService {
  static late StorageService _self;
  late Box<Save> _box;
  Future<void> _init() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Save>(SaveAdapter());
    Hive.registerAdapter<Table>(TableAdapter());
    Hive.registerAdapter<Subject>(SubjectAdapter());
    Hive.registerAdapter<StudyTime>(StudyTimeAdapter());
    Hive.registerAdapter<Task>(TaskAdapter());
    Hive.registerAdapter<Priority>(PriorityAdapter());
    Hive.registerAdapter<SubjectContent>(SubjectContentAdapter());
    Hive.registerAdapter<ContentUnderstanding>(ContentUnderstandingAdapter());
    Hive.registerAdapter<SubjectScore>(SubjectScoreAdapter());

    await Hive.openBox<Save>("save").then((v) {
      _box = v;
      if (!hasSaveData()) {
        _fixSaveData();
      }
    }).onError((error, stackTrace) async {
      log("Save file damaged!");
      await Hive.deleteBoxFromDisk("save");
      Hive.openBox<Save>("save").then((x) {
        _box = x;
        if (!hasSaveData()) {
          _fixSaveData();
        }
      });
    });
  }

  Future<void> _fixSaveData() async {
    Table exampleTable = Table(name: "Example Table");
    Subject exampleSubject = Subject(name: "Example Subject");
    exampleSubject.room = "Sc-709";
    exampleSubject.studyTimes.add(StudyTime(day: 1, startTime: 500, width: 90));
    exampleTable.subjectList.add(exampleSubject);
    exampleSubject.contents.add(SubjectContent(
        title: "Example content",
        description: "This is example content!",
        understanding: ContentUnderstanding.high));

    Save saveData = Save(mainTable: exampleTable);
    saveData.tasks.add(Task(
      title: "Example task",
      description: "This is example task",
      priority: Priority.lowest,
    ));
    saveData.tasks.add(Task(
        title: "Important example task",
        description: "This is important example",
        priority: Priority.highest));

    await _box.put("save", saveData);
  }

  /// return true if save data is exist otherwise false.
  bool hasSaveData() {
    return getSaveData() != null;
  }

  /// return save data. If everything is ok, it will never return null.
  ///
  /// ส่งข้อมูลที่บันทึกกลับมาให้ ถ้าทุกอย่างถูกต้อง มันจะไม่ส่งกลับ null
  ///
  /// การ return null อาจเกิดได้จากการสร้าง object จากคลาส `StorageService` แล้วไม่ได้ `_init()`.
  Save? getSaveData() {
    return _box.get("save");
  }

  /// Save the data.
  Future<void> saveData() async {
    if (!hasSaveData()) {
      throw Exception("Cannot save the data because the data is not exist.");
    }
    await _self.getSaveData()!.save();
  }

  /// เริ่มต้นการทำงานของ StorageService
  ///
  /// จะต้องเรียกใช้ฟังก์ชันนี้ก่อนใช้งาน StorageService ทุกครั้ง
  static Future<void> initialize() async {
    _self = StorageService();
    await _self._init();
    _self.getSaveData()!.sortTasksFromDueDate();
  }

  /// ส่งกลับ object ของ StorageService แล้วนำ object นี้ไปใช้งานต่อ
  static StorageService getService() {
    return _self;
  }

  /// ปิด StorageService แล้ว StorageService นี้จะใช้งานไม่ได้จนกว่าจะ initialize ใหม่
  static Future<void> close() async {
    await _self._box.close();
  }
}
