import 'package:flutter/material.dart';

Widget createTableWidget(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.8,
    color: Colors.amber[100],
    child: InteractiveViewer(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [Text("Hello world")],
    )),
  );
}
