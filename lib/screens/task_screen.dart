import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haolearn/models/task.dart';
import 'package:haolearn/screens/task_detail_screen.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:page_transition/page_transition.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _service = StorageService.getService();
  String? taskNameChange, description;
  double? fullscore;
  int sortBy = 0;
  bool sortGate = true;
  @override
  Widget build(BuildContext context) {
    final data = _service.getSaveData()!;

    if (sortGate) {
      if (sortBy == 0) {
        data.sortTasksFromDueDate();
      } else {
        data.sortTasksFromPriority();
      }
    }

    return Scaffold(
      appBar: createKAppBar(context, "Task"),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: kuSecColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${data.tasks.length} Task${data.tasks.length == 1 ? '' : 's'}",
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            const Text("Sort by : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                            DropdownButton(
                                value: sortBy,
                                items: const [
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("Due Date",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Priority",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                  )
                                ],
                                onChanged: (v) {
                                  sortBy = v!;
                                  StorageService.getService()
                                      .saveData()
                                      .then((v) {
                                    setState(() {});
                                  });
                                }),
                          ],
                        ),
                        Row(children: [
                          IconButton(
                              onPressed: (() {
                                sortGate = false;
                                Task task = Task();
                                data.tasks.add(task);
                                _service.saveData().then((value) {
                                  Navigator.push(
                                          context,
                                          PageTransition(
                                              child: TaskDetailScreen(
                                                  index: data.tasks.length - 1,
                                                  editToggle: true),
                                              type: PageTransitionType
                                                  .leftToRight,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              reverseDuration: const Duration(
                                                  milliseconds: 500)))
                                      .then((value) {
                                    setState(() {
                                      sortGate = true;
                                    });
                                  });
                                });
                              }),
                              icon: const Icon(
                                Icons.add,
                                size: 40,
                              ))
                        ])
                      ]),
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  height: 5,
                  width: 340,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.getTaskList().length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    PageTransition(
                                        child: TaskDetailScreen(index: index),
                                        type: PageTransitionType.leftToRight,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        reverseDuration:
                                            const Duration(milliseconds: 500)))
                                .then((value) {
                              setState(() {});
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 22),
                            child: Container(
                              decoration: kuBoxStyle,
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, top: 10, right: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${data.tasks[index].dueDate ?? "ไม่ระบุ"}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white)),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(data.tasks[index].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(data.tasks[index].score.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white)),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        RatingBarIndicator(
                                          rating: data
                                              .tasks[index].priority.level
                                              .toDouble(),
                                          itemCount: 5,
                                          itemSize: 20,
                                          itemBuilder: (context, index) {
                                            return const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
