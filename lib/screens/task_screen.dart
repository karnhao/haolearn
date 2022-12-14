import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:haolearn/models/task.dart';
import 'package:haolearn/screens/task_detail_screen.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/delete_dialog_function.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:haolearn/utils/utils.dart';
import 'package:haolearn/utils/show_snack_bar.dart';
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
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            const Text("Sort by : ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                            DropdownButton(
                                dropdownColor: Colors.white,
                                value: sortBy,
                                items: const [
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("Due Date",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red)),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Priority",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red)),
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
                              icon: const Icon(Icons.add,
                                  size: 40, color: Colors.white))
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
                        final date = data.tasks[index].dueDate;
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
                            child: Slidable(
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.transparent,
                                      icon: Icons.delete,
                                      foregroundColor: Colors.red,
                                      onPressed: (context) {
                                        showDeleteDialog(
                                          context,
                                          onDeleteConfirm: () {
                                            log("$index");
                                            data.tasks.removeAt(index);

                                            _service.saveData().then((value) {
                                              showSnackBar("Delete successful",
                                                  backgroundColor:
                                                      Colors.green);
                                              setState(() {});
                                            });
                                          },
                                        );
                                      },
                                    ),
                                    SlidableAction(
                                        backgroundColor: Colors.transparent,
                                        icon: Icons.check,
                                        onPressed: (context) {
                                          data.tasks[index].complete = true;
                                          setState(() {});
                                        }),
                                    SlidableAction(
                                        backgroundColor: Colors.transparent,
                                        icon: Icons.edit,
                                        onPressed: (context) {
                                          Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: TaskDetailScreen(
                                                          index: index,
                                                          editToggle: true),
                                                      type: PageTransitionType
                                                          .leftToRight,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      reverseDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  500)))
                                              .then((value) {
                                            setState(() {});
                                          });
                                        }),
                                  ]),
                              child: Container(
                                decoration: !data.getTaskList()[index].complete
                                    ? kuBoxStyle
                                    : createKuBoxStyle(color: Colors.grey),
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, top: 10, right: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              date == null
                                                  ? "No Due Date Data"
                                                  : "${date.day}/${date.month}/${date.year} ${formatTime(date.hour.toString())}:${formatTime(date.minute.toString())}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                204,
                                            child: Text(data.tasks[index].title,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              "Score : ${data.tasks[index].score}",
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
                                              Color color = Colors.red;
                                              switch (index) {
                                                case 4:
                                                  color = Colors.red;
                                                  break;
                                                case 3:
                                                  color = Colors.orange;
                                                  break;
                                                case 2:
                                                  color = Colors.yellow;
                                                  break;
                                                case 1:
                                                  color = Colors.green;
                                                  break;
                                                default:
                                                  color = Colors.blue;
                                              }
                                              return Icon(
                                                Icons.priority_high,
                                                color: color,
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
