import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:haolearn/models/notification_model.dart';
import 'package:haolearn/models/priority.dart';
import 'package:haolearn/services/notification_service.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/delete_dialog_alert.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:haolearn/utils/show_snack_bar.dart';
import 'package:haolearn/utils/utils.dart';

class TaskDetailScreen extends StatefulWidget {
  final int index;
  final bool editToggle;

  const TaskDetailScreen(
      {super.key, required this.index, this.editToggle = false});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final formKey = GlobalKey<FormState>();
  bool update = true;
  bool toggle = false;
  final service = StorageService.getService();
  DateTime? selectedDate;
  String? title, description;
  double? fullscore;
  late Priority priority;
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    final task = data.tasks[widget.index];

    if (update) {
      selectedDate = data.tasks[widget.index].dueDate;
      toggle = widget.editToggle;
      title = task.title;
      description = task.description;
      fullscore = task.score;
      priority = task.priority;
      update = false;
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: createKAppBar(context, task.title),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Container(
              decoration: const BoxDecoration(
                color: appBackgroundColor,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        onChanged: (value) {
                          title = value;
                        },
                        validator: (value) {
                          if (value!.trim() == "") {
                            return "Please enter task title";
                          }
                          return null;
                        },
                        initialValue: data.tasks[widget.index].title,
                        enabled: toggle,
                        style: const TextStyle(fontSize: 32),
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.red, fontSize: 18),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: "Task",
                            labelStyle: const TextStyle(fontSize: 32),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.blue),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            description = value;
                          },
                          initialValue: data.tasks[widget.index].description,
                          enabled: toggle,
                          style: const TextStyle(fontSize: 32),
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: "Description",
                              labelStyle: const TextStyle(fontSize: 32),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          try {
                            fullscore = double.parse(value);
                          } catch (e) {
                            fullscore = 0;
                          }
                        },
                        initialValue: fullscore.toString(),
                        keyboardType: TextInputType.number,
                        enabled: toggle,
                        validator: (value) {
                          try {
                            double.parse(value!);
                          } catch (e) {
                            return "Cannot format text to number. $e";
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 32),
                        decoration: InputDecoration(
                          errorStyle:
                              const TextStyle(color: Colors.red, fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.blue),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Full score",
                          labelStyle: const TextStyle(fontSize: 32),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedDate != null
                              ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                  " ${formatTime(selectedDate!.hour.toString())}"
                                  ":${formatTime(selectedDate!.minute.toString())}"
                              : "Select Due Date",
                          style: const TextStyle(fontSize: 32),
                        ),
                        IconButton(
                            onPressed: toggle
                                ? selectedDate == null
                                    ? () {
                                        _selectDate(context).then((v) {
                                          selectedDate = v;
                                          setState(() {});
                                        });
                                      }
                                    : () {
                                        setState(() {
                                          selectedDate = null;
                                        });
                                      }
                                : null,
                            icon: Icon(selectedDate == null
                                ? Icons.edit
                                : Icons.cancel_outlined))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Priority : ",
                            style: TextStyle(fontSize: 28)),
                        const SizedBox(
                          width: 40,
                        ),
                        toggle
                            ? DropdownButton(
                                dropdownColor: Colors.white,
                                value: priority.name,
                                items: Priority.values
                                    .map((t) => DropdownMenuItem(
                                          value: t.name,
                                          child: Text(
                                            t.name,
                                            style:
                                                const TextStyle(fontSize: 28),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (v) {
                                  for (Priority p in Priority.values) {
                                    if (p.name == v) {
                                      priority = p;
                                      setState(() {});
                                      return;
                                    }
                                  }
                                },
                              )
                            : Text(task.priority.name,
                                style: const TextStyle(fontSize: 28)),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: InkWell(
                            onTap: toggle
                                ? () {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }
                                    toggle = false;
                                    showDialog(
                                        context: context,
                                        builder: (context) => const Center(
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 4),
                                            ));
                                    data.tasks[widget.index].title =
                                        title ?? "ERROR";
                                    data.tasks[widget.index].description =
                                        description ?? "ERROR";
                                    data.tasks[widget.index].score =
                                        fullscore ?? 0;
                                    data.tasks[widget.index].dueDate =
                                        selectedDate;
                                    data.tasks[widget.index].priority =
                                        priority;

                                    try {
                                      if (data.tasks[widget.index].dueDate !=
                                          null) {
                                        final dueDate =
                                            data.tasks[widget.index].dueDate!;
                                        data.tasks[widget.index].registerNotification(
                                            NotificationModel(
                                                title:
                                                    "${task.title} | Due Date tomorrow",
                                                message:
                                                    "Don't forget to summit the homework - ${task.description}",
                                                id: data.tasks[widget.index].id,
                                                showTime: DateTime(
                                                    dueDate.year,
                                                    dueDate.month,
                                                    dueDate.day - 1,
                                                    dueDate.hour,
                                                    dueDate.minute,
                                                    dueDate.second,
                                                    dueDate.millisecond,
                                                    dueDate.microsecond)),
                                            NotificationChannel.homework);
                                      }
                                    } catch (e) {
                                      // Nothing
                                    }

                                    service.saveData().then((value) {
                                      Navigator.pop(context);
                                      setState(() {});
                                      showSnackBar("Save complete",
                                          backgroundColor: Colors.green);
                                      Navigator.pop(context);
                                    });
                                  }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 1),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: toggle ? kuPriColor : Colors.grey,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Save",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        Icons.save,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              if (toggle) {
                                task.complete = !task.complete;
                                service.saveData().then((value) {
                                  setState(() {});
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 1),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: toggle
                                          ? task.complete
                                              ? Colors.red
                                              : kuPriColor
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        task.complete
                                            ? "Mark as not finish"
                                            : "Mark as done",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Row(
              children: [
                // Delete
                DeleteConfirm(
                  function: () {
                    data.tasks.removeAt(widget.index);
                    setState(() {});
                    Navigator.pop(context, 'OK');
                  },
                ),
                InkWell(
                    onTap: () {},
                    child: Switch(
                      value: toggle,
                      onChanged: (value) {
                        setState(
                          () {
                            toggle = value;
                          },
                        );
                      },
                      activeColor: Colors.green,
                      activeTrackColor: Colors.lightGreenAccent,
                    )),
              ],
            ),
          )
        ]));
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2050, 12, 31),
        onChanged: (date) {},
        onConfirm: (date) {},
        currentTime: DateTime.now(),
        locale: LocaleType.th);
  }
}
