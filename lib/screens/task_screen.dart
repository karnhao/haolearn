import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:haolearn/models/task.dart';
import 'package:haolearn/screens/subject_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    final data = _service.getSaveData()!;
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
              color: Color.fromARGB(255, 138, 138, 138),
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
                        const Text(
                          "Task",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700),
                        ),
                        Row(children: [
                          IconButton(
                              onPressed: (() {}),
                              icon: const Icon(
                                Icons.delete,
                                size: 40,
                              )),
                          IconButton(
                              onPressed: (() {
                                data.tasks.add(Task());
                                _service.saveData().then((value) {
                                  setState(() {});
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
                                    duration: const Duration(milliseconds: 500),
                                    reverseDuration:
                                        const Duration(milliseconds: 500)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 22),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 80, 80, 80),
                                  borderRadius: BorderRadius.circular(20)),
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
                                      children: [
                                        Text(data.tasks[index].dueDate
                                            .toString()),
                                        Text(data.tasks[index].title)
                                      ],
                                    ),
                                    Text(data.tasks[index].priority.toString()),
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
