import 'package:flutter/material.dart';
import 'package:haolearn/main.dart';

void showSnackBar(String? text, {Color? backgroundColor}) {
  if (text == null) return;

  final snackBar = SnackBar(
    content: Text(
      text,
      selectionColor: Colors.white,
    ),
    backgroundColor: backgroundColor ?? Colors.red,
  );

  messageKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
