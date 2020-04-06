import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

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
  List<Task> tasks = <Task>[];
  Task selectedTask;

  //Task Creator Screen
  bool showCreateTaskDialog = false;
  bool showEditTaskDialog = false;
  TextEditingController taskTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();
  int unitSelected;

  //------------
  //--METHODS
  //------------
  void getTasks() async {
    final Box<Task> tasksBox = await Hive.openBox<Task>('tasks');
    final List<Task> newList = <Task>[];

    for (int i = 0; i < tasksBox.length; i++) {
      newList.add(tasksBox.getAt(i));
    }

    setState(() {
      tasks = newList;
    });
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

  void openCreateTaskDialog() {
    if (!showCreateTaskDialog) {
      setState(() {
        taskTextController.clear();
        quantityTextController.clear();
        unitSelected = 0;
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

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
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
      body: tasks.isNotEmpty
          ? ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final Task currentTask = tasks[index];
                return Card(
                  child: Container(
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('${currentTask.id} ${currentTask.name}'),
                          onTap: () {
                            openEditTaskDialog(currentTask);
                          },
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                color: Colors.greenAccent,
                                child: IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      tasks[index].quantity--;
                                      _updateTask(
                                          tasks[index], tasks[index].id);
                                    });
                                  },
                                ),
                              ),
                              Text(
                                  '${currentTask.quantity} ${getUnitName(currentTask.unit)}'),
                              Container(
                                color: Colors.redAccent,
                                child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      tasks[index].quantity++;
                                      _updateTask(
                                          tasks[index], tasks[index].id);
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
              itemCount: tasks.length)
          : const Center(
              child: Text('Nothing to do... Great!'),
            ),
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
                    selectedTask.repeatingDays);
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
                    0000000);
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
