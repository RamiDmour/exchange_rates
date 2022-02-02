/// YTT - yesterday, today and tomorrow
extension YTTDateTimeExtension on DateTime {
  static DateTime get yesterday {
    final DateTime currentDate = DateTime.now();

    return DateTime(currentDate.year, currentDate.month, currentDate.day - 1);
  }

  static DateTime get today {
    final DateTime currentDate = DateTime.now();

    return DateTime(currentDate.year, currentDate.month, currentDate.day);
  }

  static DateTime get tomorrow {
    final DateTime currentDate = DateTime.now();

    return DateTime(currentDate.year, currentDate.month, currentDate.day + 1);
  }
}
