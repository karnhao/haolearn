String formatTime(String s) {
  return s.length > 1 ? s : "0$s";
}

String minuteToTime(int minutes) {
  return "${formatTime((minutes ~/ 60).toString())}:${formatTime((minutes % 60).toString())}";
}
