import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:haolearn/models/notification_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

enum NotificationChannel {
  homework(description: "homework notification channel");

  final String description;
  const NotificationChannel({required this.description});
}

class NotificationService {
  final String postURL = "https://myapi.ku.th/auth/login";
  static late NotificationService _self;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    try {
      _self = NotificationService();

      _self.flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      _self.flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .pendingNotificationRequests();

      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
      );
      await _self.flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: notificationTapBackground);
    } catch (e) {
      log("NOT SUPPORTED : $e");
    }
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    // handle action
  }

  static NotificationService getService() {
    return _self;
  }

  FlutterLocalNotificationsPlugin getPlugin() {
    return flutterLocalNotificationsPlugin;
  }

  Future<void> addNotification(
      NotificationModel notificationModel, NotificationChannel channel) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(notificationModel.id);
    } catch (e) {
      log("Creating new notification...");
      // DO NOTTHING
    }

    await showNotificationInFuture(
        id: notificationModel.id,
        channel: channel,
        title: notificationModel.title,
        description: notificationModel.message,
        showTime: notificationModel.showTime);
  }

  Future<void> showNotificationInFuture(
      {required int id,
      required NotificationChannel channel,
      required String title,
      required String description,
      required DateTime showTime}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.name, channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    flutterLocalNotificationsPlugin.zonedSchedule(id, title, description,
        tz.TZDateTime.from(showTime, tz.local), notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
  }

  Future<void> removeNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  void showNotification(
      {required NotificationChannel channel,
      required int id,
      String title = "Title",
      String description = "Description"}) {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.name, channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      description,
      notificationDetails,
    );
  }
}
