import 'package:flutter/material.dart';
import 'package:haolearn/themes/colors.dart';

ThemeData appTheme() {
  return ThemeData(
      fontFamily: "DB-Ozone-X",
      textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.w700, color: kuSecColor),
          headline2: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.white)),
      scaffoldBackgroundColor: appBackgroundColor,
      useMaterial3: true);
}
