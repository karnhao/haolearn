import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/delete_dialog_alert.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:haolearn/utils/loading_dialog.dart';
import 'package:haolearn/utils/show_snack_bar.dart';
import 'package:haolearn/utils/utils.dart';

class TaskDetailScreen extends StatefulWidget {
  final int index;

  const TaskDetailScreen({super.key, required this.index});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  String subjectName = "Subject";
  bool update = true;
  bool toggle = false;
  final service = StorageService.getService();
  DateTime? selectedDate;
  String? title, description;
  double? fullscore;
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    final task = data.tasks[widget.index];
    if (data.tasks[widget.index].dueDate != null) {
      selectedDate = data.tasks[widget.index].dueDate!;
    }
    if (update) {
      title = task.title;
      description = task.description;
      fullscore = task.score;
      update = false;
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: createKAppBar(context, "$subjectName task"),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Container(
              decoration: const BoxDecoration(
                color: appBackgroundColor,
              ),
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
                      initialValue: data.tasks[widget.index].title,
                      enabled: toggle,
                      style: const TextStyle(fontSize: 32),
                      decoration: InputDecoration(
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
                    child: TextField(
                      onChanged: (value) {
                        fullscore = double.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      enabled: toggle,
                      style: const TextStyle(fontSize: 32),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.blue),
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
                    child: RatingBar(
                      ignoreGestures: !toggle,
                      minRating: 1,
                      maxRating: 5,
                      allowHalfRating: false,
                      itemSize: 40,
                      initialRating: 1,
                      onRatingUpdate: (value) {},
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star, color: Colors.amber),
                          half: const Icon(Icons.circle, color: Colors.amber),
                          empty: const Icon(
                            Icons.star_border_purple500_outlined,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => const Center(
                                  child:
                                      CircularProgressIndicator(strokeWidth: 4),
                                ));
                        data.tasks[widget.index].title = title ?? "ERROR";
                        data.tasks[widget.index].description =
                            description ?? "ERROR";
                        data.tasks[widget.index].score = fullscore ?? 0;
                        data.tasks[widget.index].dueDate = selectedDate;

                        service.saveData().then((value) {
                          Navigator.pop(context);
                          setState(() {});
                          showSnackBar("Save complete",
                              backgroundColor: Colors.green);
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: kuPriColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Save",
                                style: Theme.of(context).textTheme.headline1,
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
                ],
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
                  function: () {},
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
