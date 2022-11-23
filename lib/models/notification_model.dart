class NotificationModel {
  final int id;
  final String title;
  final String message;
  final DateTime showTime;

  NotificationModel(
      {required this.id,
      required this.showTime,
      this.title = "Alert",
      this.message = "Nothing :)"});
}
