import 'dart:developer';

import 'package:haolearn/models/save.dart';
import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/models/subject.dart';
import 'package:haolearn/models/table.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static late StorageService _self;
  late Box<Save> _box;
  Future<void> _init() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Save>(SaveAdapter());
    Hive.registerAdapter<Table>(TableAdapter());
    Hive.registerAdapter<Subject>(SubjectAdapter());
    Hive.registerAdapter<StudyTime>(StudyTimeAdapter());

    _box = await Hive.openBox<Save>("save");
    if (!hasSaveData()) {
      log("Creating save data...");
      Table exampleTable = Table(name: "Example Table");
      Subject exampleSubject = Subject(name: "Example Subject");
      exampleSubject.room = "Sc-709";
      exampleSubject.studyTimes
          .add(StudyTime(day: 1, startTime: 500, width: 90));
      exampleTable.subjectList.add(exampleSubject);
      await _box.put("save", Save(table: exampleTable));
    }
  }

  bool hasSaveData() {
    return getSaveData() != null;
  }

  Save? getSaveData() {
    return _box.get("save");
  }

  static Future<void> initialize() async {
    _self = StorageService();
    await _self._init();
  }

  static StorageService getService() {
    return _self;
  }

  static Future<void> close() async {
    await _self._box.close();
  }
}
