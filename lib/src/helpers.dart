String getWeekDayFromIndex(int index) {
  List<String> weekdays = <String>[ 'M', 'T', 'W', 'T', 'F', 'S', 'S' ];
  return weekdays[index];
}

String getMonthFromValue(int value) {
  List<String> months = <String>[ 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' ];
  return months[value - 1];
}

int calculateValueForCell(int start, int column, int row) {
  return 7 * column + (row + 1) - start;
}

String timeFromIndex(int index) {
  int a = index * 15;

  int hour = (a ~/ 60).ceil();
  int minutes = a % 60;

  return '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}