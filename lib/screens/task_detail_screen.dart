import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/delete_dialog_alert.dart';
import 'package:haolearn/utils/kappbar.dart';

class TaskDetailScreen extends StatefulWidget {
  final int index;

  const TaskDetailScreen({super.key, required this.index});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  String subjectName = "Subject";
  //dynamic date = "Deadline date";
  bool toggle = false;
  final service = StorageService.getService();
  DateTime selectedDate = DateTime.now();
  String? title, description;
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    if (data.tasks[widget.index].dueDate != null) {
      selectedDate = data.tasks[widget.index].dueDate!;
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: createKAppBar(context, "$subjectName task"),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: appBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          initialValue: data.tasks[widget.index].title,
                          enabled: toggle,
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: "Task",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(25))),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                      IconButton(
                          onPressed: toggle
                              ? () {
                                  _selectDate(context).then((v) {
                                    selectedDate = v ?? DateTime.now();
                                    setState(() {});
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            enabled: toggle,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(25)),
                                labelText: "Score",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 5)),
                          ),
                        ),
                        const Text("/"),
                        Expanded(
                            child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(25)),
                              labelText: "Full score",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              enabled: toggle,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 5)),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
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
                        data.tasks[widget.index].title = "TEST";
                        data.tasks[widget.index].description = "AAAA";
                        // ...

                        service.saveData();
                      },
                      child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Save",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.save,
                                color: Colors.white,
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: kuPriColor,
                              borderRadius: BorderRadius.circular(30))),
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
                const DeleteConfirm(),
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
