import 'package:shared_preferences/shared_preferences.dart';

import 'models/task.dart';

SharedPreferences prefs;
DateTime today;
int currentWeekDay;
String currentDayTitle;
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
      return 'hours';
    default:
      return 'times';
  }
}

int getLastWeekDay() {
  if (currentWeekDay == 0) {
    return 6;
  } else {
    return currentWeekDay - 1;
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

void setToday() {
  today = DateTime.now().add(Duration(days: dayOffset));
  currentDayTitle = '';

  switch (today.month) {
    case 1:
      currentDayTitle += 'January ';
      break;
    case 2:
      currentDayTitle += 'Febraury ';
      break;
    case 3:
      currentDayTitle += 'March ';
      break;
    case 4:
      currentDayTitle += 'April ';
      break;
    case 5:
      currentDayTitle += 'May ';
      break;
    case 6:
      currentDayTitle += 'June ';
      break;
    case 7:
      currentDayTitle += 'July ';
      break;
    case 8:
      currentDayTitle += 'August ';
      break;
    case 9:
      currentDayTitle += 'September ';
      break;
    case 10:
      currentDayTitle += 'October ';
      break;
    case 11:
      currentDayTitle += 'November ';
      break;
    case 12:
      currentDayTitle += 'December ';
      break;
  }

  currentDayTitle += today.day.toString();

  switch (today.weekday) {
    case 1:
      currentWeekDay = 0;
      break;
    case 2:
      currentWeekDay = 1;
      break;
    case 3:
      currentWeekDay = 2;
      break;
    case 4:
      currentWeekDay = 3;
      break;
    case 5:
      currentWeekDay = 4;
      break;
    case 6:
      currentWeekDay = 5;
      break;
    case 7:
      currentWeekDay = 6;
      break;
  }
}

String getWeekdayInString(int _dayOffset) {
  String dayName = '';

  final DateTime day = DateTime.now().add(Duration(days: _dayOffset));

  switch (day.weekday) {
    case 1:
      dayName = 'Monday';
      break;
    case 2:
      dayName = 'Tuesday';
      break;
    case 3:
      dayName = 'Wednesday';
      break;
    case 4:
      dayName = 'Thursday';
      break;
    case 5:
      dayName = 'Friday';
      break;
    case 6:
      dayName = 'Saturday';
      break;
    case 7:
      dayName = 'Sunday';
      break;
  }

  return dayName;
}

String getMonthdayInString(int _dayOffset) {
  return DateTime.now().add(Duration(days: _dayOffset)).day.toString();
}
