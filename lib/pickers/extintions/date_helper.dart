extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isTomorrow() {
    final yesterday = DateTime.now().add(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }
}
