import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';

import 'task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Hive Database pre-setup
  final Directory appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TaskAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laurens App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Laurens App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //------------
  //--VARIABLES
  //------------
  SharedPreferences prefs;
  DateTime today;
  int currentWeekDay;
  int dayOffset = 0;
  List<Task> tasks = <Task>[];
  // List<Task> filteredTasks = <Task>[];
  Task selectedTask;

  //Task Creator Screen
  bool showCreateTaskDialog = false;
  bool showEditTaskDialog = false;
  TextEditingController taskTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();
  int unitSelected;
  List<bool> daysToRepeat = <bool>[];

  //------------
  //--METHODS
  //------------
  void getTasks() async {
    // Hive.deleteBoxFromDisk('task');
    final Box<Task> tasksBox = await Hive.openBox<Task>('tasks');
    final List<Task> newList = <Task>[];

    for (int i = 0; i < tasksBox.length; i++) {
      newList.add(tasksBox.getAt(i));
    }

    // setState(() {
    tasks = newList;
    checkTodayForReset();
    // });
  }

  Future<List<Task>> _filterTasks() async {
    // Hive.deleteBoxFromDisk('task');
    final List<Task> newList = <Task>[];

    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i]
              .repeatingDays
              .substring(currentWeekDay, currentWeekDay + 1) !=
          '0') {
        newList.add(tasks[i]);
      }
    }

    return newList;
  }

  Future<void> _addTask(Task task) async {
    await Hive.box<Task>('tasks').add(task);
    getTasks();
  }

  Future<void> _updateTask(
    Task task,
    int index,
  ) async {
    await Hive.box<Task>('tasks').putAt(index, task);
    getTasks();
  }

  Future<void> _deleteTask(
    int index,
  ) async {
    tasks.removeAt(index);
    Hive.box<Task>('tasks').deleteAt(index);
    fixTaskIndicesAfter(index);
  }

  void fixTaskIndicesAfter(int index) async {
    for (int i = index; i < tasks.length; i++) {
      tasks[i].id = i;
      await Hive.box<Task>('tasks').putAt(i, tasks[i]);
    }
    getTasks();
  }

  void updateTaskWithoutGetting(
    Task task,
    int index,
  ) async {
    await Hive.box<Task>('tasks').putAt(index, task);
  }

  void checkTodayForReset() async {
    prefs = await SharedPreferences.getInstance();

    // prefs.setString('today', today.toString().substring(0, 10));
    if (today.toString().substring(0, 10) != '${prefs.getString('today')}') {
      // if (today.toString().substring(0, 10) != 'a') {
      print('new day');
      prefs.setString('today', today.toString().substring(0, 10));
      resetAllTasks();
    } else {
      setState(() {
        print('same day');
      });
    }
  }

  void resetAllTasks() {
    print('resetting tasks with a length of ${tasks.length}');
    for (int i = 0; i < tasks.length; i++) {
      tasks[i].currentQuantity = tasks[i].quantity;
      updateTaskWithoutGetting(tasks[i], i);
    }
    getTasks();
  }

  void openCreateTaskDialog() {
    if (!showCreateTaskDialog) {
      setState(() {
        taskTextController.clear();
        quantityTextController.clear();
        unitSelected = 0;
        daysToRepeat = <bool>[true, true, true, true, true, true, true];
        showCreateTaskDialog = true;
      });
    }
  }

  void openEditTaskDialog(Task currentTask) {
    if (!showEditTaskDialog) {
      setState(() {
        selectedTask = currentTask;
        taskTextController.text = currentTask.name;
        quantityTextController.text = currentTask.quantity.toString();
        unitSelected = currentTask.unit;
        showEditTaskDialog = true;
        daysToRepeat = getRepeatingDaysInList(currentTask.repeatingDays);
      });
    }
  }

  String getUnitName(int unit) {
    switch (unit) {
      case 0:
        return 'times';
      case 1:
        return 'minutes';
      case 2:
        return 'hours';
    }
  }

  String getRepeatingDaysInBinary() {
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

  @override
  void initState() {
    today = DateTime.now();
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_left),
              color: dayOffset != 0 ? Colors.white : Colors.blue,
              onPressed: () {
                //
                if (dayOffset != 0) {
                  setState(() {
                    dayOffset--;
                  });
                }
              },
            ),
            Text(getTodayInString()),
            IconButton(
              icon: Icon(Icons.arrow_right),
              color: dayOffset != 6 ? Colors.white : Colors.blue,
              onPressed: () {
                //
                if (dayOffset != 6) {
                  setState(() {
                    dayOffset++;
                  });
                }
              },
            ),
          ],
        )),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            homeScreen(),
            if (showCreateTaskDialog) taskCreator(),
            if (showEditTaskDialog) taskEditor(),
          ],
        ),
      ),
    );
  }

  Widget homeScreen() {
    return Scaffold(
      body: FutureBuilder<List<Task>>(
          future: _filterTasks(),
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data.isEmpty
                  ? const Center(
                      child: Text('Nothing to do today... Great!'),
                    )
                  : ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        final Task currentTask = snapshot.data[index];
                        return Card(
                          child: Container(
                            height: dayOffset != 0 ? 56 : 100,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                      // '${currentTask.id} ${currentTask.name} ${currentTask.repeatingDays}'),
                                      '${currentTask.name}'),
                                  onTap: () {
                                    openEditTaskDialog(currentTask);
                                  },
                                ),
                                if (dayOffset == 0)
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          color: Colors.greenAccent,
                                          child: IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              setState(() {
                                                if (tasks[index]
                                                        .currentQuantity >
                                                    0) {
                                                  tasks[index]
                                                      .currentQuantity--;
                                                  _updateTask(tasks[index],
                                                      tasks[index].id);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Text(
                                            '${currentTask.currentQuantity} ${getUnitName(currentTask.unit)}'),
                                        Container(
                                          color: Colors.redAccent,
                                          child: IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                tasks[index].currentQuantity++;
                                                _updateTask(tasks[index],
                                                    tasks[index].id);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: snapshot.data.length);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: openCreateTaskDialog,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget taskEditor() {
    return Container(
      color: Colors.black.withAlpha(200),
      child: AlertDialog(
        title: const Text('Edit Task'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              TextField(
                textAlignVertical: TextAlignVertical.bottom,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter a task',
                ),
                controller: taskTextController,
              ),
              const SizedBox(height: 10),
              TextField(
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Amount',
                ),
                controller: quantityTextController,
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            unitSelected = 0;
                          });
                        },
                        child: Text(
                          'times',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: unitSelected == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            unitSelected = 1;
                          });
                        },
                        child: Text(
                          'minutes',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: unitSelected == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            unitSelected = 2;
                          });
                        },
                        child: Text(
                          'hours',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: unitSelected == 2
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[0] = !daysToRepeat[0];
                        });
                      },
                      child: Text(
                        'M',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[0]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[1] = !daysToRepeat[1];
                        });
                      },
                      child: Text(
                        'T',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[1]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[2] = !daysToRepeat[2];
                        });
                      },
                      child: Text(
                        'W',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[2]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[3] = !daysToRepeat[3];
                        });
                      },
                      child: Text(
                        'T',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[3]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[4] = !daysToRepeat[4];
                        });
                      },
                      child: Text(
                        'F',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[4]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[5] = !daysToRepeat[5];
                        });
                      },
                      child: Text(
                        'S',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[5]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[6] = !daysToRepeat[6];
                        });
                      },
                      child: Text(
                        'S',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[6]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                print('Deleted Task');
                _deleteTask(selectedTask.id);
                showEditTaskDialog = false;
              });
            },
            child: const Text('Delete'),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                showEditTaskDialog = false;
              });
            },
            child: const Text('Cancel'),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                print('Edited Task');
                tasks[selectedTask.id] = Task(
                    selectedTask.id,
                    '${taskTextController.text}',
                    int.parse(quantityTextController.text),
                    unitSelected,
                    selectedTask.cleared,
                    getRepeatingDaysInBinary(),
                    selectedTask.currentQuantity);
                showEditTaskDialog = false;
                _updateTask(tasks[selectedTask.id], selectedTask.id);
              });
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  Widget taskCreator() {
    return Container(
      color: Colors.black.withAlpha(200),
      child: AlertDialog(
        title: const Text('Create a Task'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              TextField(
                textAlignVertical: TextAlignVertical.bottom,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter a task',
                ),
                controller: taskTextController,
              ),
              const SizedBox(height: 10),
              TextField(
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Amount',
                ),
                controller: quantityTextController,
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            unitSelected = 0;
                          });
                        },
                        child: Text(
                          'times',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: unitSelected == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            unitSelected = 1;
                          });
                        },
                        child: Text(
                          'minutes',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: unitSelected == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            unitSelected = 2;
                          });
                        },
                        child: Text(
                          'hours',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: unitSelected == 2
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[0] = !daysToRepeat[0];
                        });
                      },
                      child: Text(
                        'M',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[0]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[1] = !daysToRepeat[1];
                        });
                      },
                      child: Text(
                        'T',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[1]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[2] = !daysToRepeat[2];
                        });
                      },
                      child: Text(
                        'W',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[2]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[3] = !daysToRepeat[3];
                        });
                      },
                      child: Text(
                        'T',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[3]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[4] = !daysToRepeat[4];
                        });
                      },
                      child: Text(
                        'F',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[4]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[5] = !daysToRepeat[5];
                        });
                      },
                      child: Text(
                        'S',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[5]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[6] = !daysToRepeat[6];
                        });
                      },
                      child: Text(
                        'S',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[6]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                showCreateTaskDialog = false;
              });
            },
            child: const Text('Cancel'),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                print('Added task');
                final Task newTask = Task(
                    tasks.length,
                    '${taskTextController.text}',
                    int.parse(quantityTextController.text),
                    unitSelected,
                    false,
                    getRepeatingDaysInBinary(),
                    int.parse(quantityTextController.text));
                tasks.add(newTask);
                showCreateTaskDialog = false;
                _addTask(newTask);
              });
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
