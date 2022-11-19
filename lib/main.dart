import 'package:flutter/material.dart';
import 'package:haolearn/route.dart';
import 'package:haolearn/themes/styles.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
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
