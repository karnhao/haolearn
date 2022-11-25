import 'package:flutter/material.dart';

const Color kuSecColor = Color.fromARGB(255, 178, 187, 30);
const Color kuPriColor = Color.fromARGB(255, 0, 102, 100);
const Color appBackgroundColor = Color.fromARGB(255, 255, 255, 255);
const Color appBackgroundColor2 = Color.fromARGB(255, 255, 255, 255);
const Color kappHeadline2 = Color.fromARGB(255, 6, 75, 224);
const Color kBoxColor = Color.fromARGB(255, 99, 197, 115);
const Color kBoxColorBorder = Color.fromARGB(255, 99, 215, 115);

BoxDecoration kuBoxStyle = BoxDecoration(boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.9),
    spreadRadius: 0.1,
    blurRadius: 7,
    offset: const Offset(0, 3), // changes position of shadow
  ),
], color: kuPriColor, borderRadius: BorderRadius.circular(20));

BoxDecoration createKuBoxStyle({Color color = kuPriColor}) {
  return BoxDecoration(boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.9),
      spreadRadius: 0.1,
      blurRadius: 7,
      offset: const Offset(0, 3), // changes position of shadow
    ),
  ], color: color, borderRadius: BorderRadius.circular(20));
}
