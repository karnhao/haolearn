import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:haolearn/models/subject.dart';
import 'package:haolearn/screens/subject_screen.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/delete_dialog_function.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:haolearn/utils/show_snack_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListSubjectScreen extends StatefulWidget {
  const ListSubjectScreen({super.key});

  @override
  State<ListSubjectScreen> createState() => _ListSubjectScreenState();
}

class _ListSubjectScreenState extends State<ListSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    final subjectList = data.mainTable.subjectList;

    return Scaffold(
      appBar: createKAppBar(context, "Subjects"),
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
                          "${subjectList.length} Subject${subjectList.length == 1 ? '' : 's'}",
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700),
                        ),
                        Row(children: [
                          IconButton(
                              onPressed: (() {
                                setState(() {
                                  subjectList.add(Subject(name: "Unname"));
                                  service.saveData();
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ReorderableListView.builder(
                        itemBuilder: ((context, index) {
                          return Slidable(
                            key: Key(index.toString()),
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                      onPressed: (context) {
                                        showDeleteDialog(
                                          context,
                                          onDeleteConfirm: () {
                                            subjectList.removeAt(index);

                                            service.saveData().then((value) {
                                              showSnackBar("Delete successful",
                                                  backgroundColor:
                                                      Colors.green);
                                              setState(() {});
                                            });
                                          },
                                        );
                                      },
                                      label: "Delete",
                                      icon: Icons.delete,
                                      autoClose: true,
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.red),
                                  SlidableAction(
                                      onPressed: (context) {},
                                      label: "Edit",
                                      icon: Icons.edit,
                                      autoClose: true,
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white),
                                ]),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        PageTransition(
                                            child: SubjectScreen(index: index),
                                            type:
                                                PageTransitionType.leftToRight,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            reverseDuration: const Duration(
                                                milliseconds: 500)))
                                    .then((v) {
                                  setState(() {});
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.9),
                                          spreadRadius: 0.1,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: kuPriColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Room : ${subjectList[index].room ?? 'ไม่ระบุ'}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white)),
                                        Text(subjectList[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        itemCount: subjectList.length,
                        onReorder: (old, current) {
                          if (current > old) {
                            for (int i = old; i < current - 1; i++) {
                              data.getMainTable()!.swapSubject(i, i + 1);
                            }
                            service.saveData();
                          } else if (old > current) {
                            for (int i = old; i > current; i--) {
                              log("$i ${i - 1}");
                              data.getMainTable()!.swapSubject(i, i - 1);
                            }
                            service.saveData();
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
