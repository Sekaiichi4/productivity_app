import 'package:shared_preferences/shared_preferences.dart';

import 'models/task.dart';

SharedPreferences prefs;
DateTime today;
int currentWeekDay;
int dayOffset = 0;
List<Task> tasks = <Task>[];
List<Task> filteredTasks = <Task>[];

//------------
//--METHODS
//------------
String getUnitName(int unit) {
  switch (unit) {
    case 0:
      return 'times';
    case 1:
      return 'minutes';
    case 2:
      return 'sets';
  }
}

String getRepeatingDaysInBinary(List<bool> daysToRepeat) {
  String days = '';

  for (int i = 0; i < 7; i++) {
    if (daysToRepeat[i]) {
      days += '1';
    } else {
      days += '0';
    }
  }
  print('REPEATING DAYS BINARY IS $days');
  return days;
}

List<bool> getRepeatingDaysInList(String daysInString) {
  final List<bool> days = <bool>[];

  for (int i = 0; i < 7; i++) {
    if (daysInString.substring(i, i + 1) == '1') {
      days.add(true);
    } else {
      days.add(false);
    }
  }

  return days;
}

String getTodayInString() {
  String todayName = '';

  today = DateTime.now().add(Duration(days: dayOffset));

  switch (today.weekday) {
    case 1:
      todayName += 'Monday ';
      currentWeekDay = 0;
      break;
    case 2:
      todayName += 'Tuesday ';
      currentWeekDay = 1;
      break;
    case 3:
      todayName += 'Wednesday ';
      currentWeekDay = 2;
      break;
    case 4:
      todayName += 'Thursday ';
      currentWeekDay = 3;
      break;
    case 5:
      todayName += 'Friday ';
      currentWeekDay = 4;
      break;
    case 6:
      todayName += 'Saturday ';
      currentWeekDay = 5;
      break;
    case 7:
      todayName += 'Sunday ';
      currentWeekDay = 6;
      break;
  }

  todayName += '${today.day}-${today.month}-${today.year}';

  return todayName;
}
