import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart';
import 'task.dart';

class TaskData extends ChangeNotifier {
  static const String boxNameTasks = 'tasks';
  Task activeTask;

  void getTasks() async {
    // Hive.deleteBoxFromDisk('task');
    final Box<Task> tasksBox = await Hive.openBox<Task>(boxNameTasks);
    tasks = tasksBox.values.toList();

    filterTasks();

    checkTodayForReset();
  }

  void filterTasks() {
    final List<Task> newList = <Task>[];

    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i]
              .repeatingDays
              .substring(currentWeekDay, currentWeekDay + 1) !=
          '0') {
        newList.add(tasks[i]);
      }
    }
    filteredTasks = newList;
  }

  void checkTodayForReset() async {
    prefs = await SharedPreferences.getInstance();
    final DateTime realToday = DateTime.now();

    // prefs.setString('today', today.toString().substring(0, 10));
    if (realToday.toString().substring(0, 10) !=
        '${prefs.getString('today')}') {
      // if (today.toString().substring(0, 10) != 'a') {
      print('new day');
      prefs.setString('today', realToday.toString().substring(0, 10));
      resetAllTasks();
    } else {
      // print('Last day was ${getLastWeekDay()}');
      print('same day');
      notifyListeners();
    }
  }

  void resetAllTasks() {
    //TODO: Maybe have a bool that lets the list wait while it is resetting before showing the content.
    print('resetting tasks with a length of ${tasks.length}');
    for (int i = 0; i < tasks.length; i++) {
      tasks[i].currentQuantity = 0;
      if (tasks[i].cleared) {
        tasks[i].cleared = false;
      } else {
        if (tasks[i]
                .repeatingDays
                .substring(getLastWeekDay(), getLastWeekDay() + 1) !=
            '0') {
          tasks[i].currentStreak = 0;
        }
      }
      updateTaskWithoutGetting(tasks[i], i);
    }
    getTasks();
  }

  Task getTask(int index) {
    return tasks[index];
  }

  void addTask(Task task) async {
    await Hive.box<Task>(boxNameTasks).add(task);
    getTasks();
  }

  void updateTask(
    Task task,
    int index,
  ) async {
    await Hive.box<Task>(boxNameTasks).putAt(index, task);

    activeTask = task;

    getTasks();
  }

  void updateTaskWithoutGetting(
    Task task,
    int index,
  ) async {
    await Hive.box<Task>('tasks').putAt(index, task);
  }

  void deleteTask(
    int index,
  ) async {
    print('Going to delete on index $index');
    tasks.removeAt(index);
    Hive.box<Task>(boxNameTasks).deleteAt(index);
    fixTaskIndicesAfter(index);
  }

  void fixTaskIndicesAfter(int index) async {
    for (int i = index; i < tasks.length; i++) {
      tasks[i].id = i;
      await Hive.box<Task>(boxNameTasks).putAt(i, tasks[i]);
    }
    getTasks();
  }

  int get tasksCount {
    return tasks.length;
  }

  int get filteredTasksCount {
    return filteredTasks.length;
  }

  void setActiveTask(int index) {
    activeTask = tasks[index];

    notifyListeners();
  }

  Task getActiveTask() {
    return activeTask;
  }
}
