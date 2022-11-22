import 'package:flutter/material.dart';
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
          backgroundColor: kuPriColor,
          toolbarHeight: 70,
        ),
        body: Stack(children: [
          Container(
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
                    height: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: kBoxColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width: 1, color: kBoxColorBorder)),
                    child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          decoration:
                              InputDecoration(hintText: 'Enter something'),
                        )),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: kBoxColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width: 1, color: kBoxColorBorder)),
                    child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          decoration:
                              InputDecoration(hintText: 'Enter something'),
                        )),
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: kuPriColor,
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
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: kuPriColor,
                    foregroundColor: kuSecColor,
                    child: Text('Score'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: appBackgroundColor,
                    foregroundColor: Colors.black,
                    child: Text('Time'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/notesubject");
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: kuPriColor,
                      foregroundColor: kuSecColor,
                      child: Text('Note'),
                    ),
                  )
                ],
              ),
            ),
          ), //Positioned
        ]));
  }
}
