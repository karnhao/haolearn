import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haolearn/route.dart';
import 'package:haolearn/services/notification_service.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/styles.dart';

Future<void> main() async {
  log("Starting...");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await StorageService.initialize();
  await NotificationService.initialize();
  ErrorWidget.builder = (details) {
    return Text('ERROR! : ${details.exception}',
        style: const TextStyle(
            color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 20));
  };
  runApp(const MyApp());
}

final messageKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messageKey,
      debugShowCheckedModeBanner: false,
      title: 'Haolearn',
      theme: appTheme(),
      routes: routes,
      initialRoute: "/home",
    );
  }
}
