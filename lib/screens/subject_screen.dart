import 'package:flutter/material.dart';
import 'package:haolearn/models/subject.dart';
import 'package:haolearn/themes/colors.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Subject",
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: kappBarColor,
          toolbarHeight: 70,
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
                color: kappBackground,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: kBoxColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width: 1, color: kBoxColorBorder)),
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Enter fuxking something'),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: kBoxColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width: 1, color: kBoxColorBorder)),
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Enter fuxking something'),
                        )),
                  ),
                ),
                SizedBox(height: 50),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kappBarColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: kCircleAvatar,
                    foregroundColor: kappBarTextColor,
                    child: Text('Score'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: kCircleAvatar,
                    foregroundColor: kappBarTextColor,
                    child: Text('Time'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: kCircleAvatar,
                    foregroundColor: kappBarTextColor,
                    child: Text('Task'),
                  )
                ],
              ),
            ),
          ), //Positioned
        ]));
  }
}
