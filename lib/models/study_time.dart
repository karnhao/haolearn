class StudyTime {
  int day;
  int startTime;
  int width;

  StudyTime({required this.day, required this.startTime, required this.width});

  int getDay() {
    return day;
  }

  int getStartTime() {
    return startTime;
  }

  int getWidth() {
    return width;
  }

  int getEndTime() {
    return startTime + width;
  }

  int getStartHour() {
    return startTime ~/ 60;
  }

  int getStartMinute() {
    return startTime % 60;
  }

  int getEndHour() {
    return (startTime + width) ~/ 60;
  }

  int getEndMinute() {
    return (startTime + width) % 60;
  }

  String getDayName() {
    try {
      return [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
      ][day];
    } catch (e) {
      return "N/A";
    }
  }

  String getTimeName() {
    return "${_getTimeString(startTime)} - ${_getTimeString(startTime + width)}";
  }

  static String _getTimeString(int time) {
    return "${_formatTime((time ~/ 60).toString())}:${_formatTime((time % 60).toString())}";
  }

  static String _formatTime(String s) {
    return s.length > 1 ? s : "0$s";
  }
}
