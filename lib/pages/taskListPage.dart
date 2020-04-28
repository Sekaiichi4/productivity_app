import 'package:flutter/material.dart';
import 'package:productivity_helper/models/task.dart';
import 'package:productivity_helper/models/taskData.dart';
import 'package:productivity_helper/widgets/taskList.dart';
import 'package:provider/provider.dart';

import '../globals.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key key}) : super(key: key);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isCreatingTask = false;

  @override
  void initState() {
    today = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TaskData>(context, listen: false).getTasks();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_left),
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
                icon: const Icon(Icons.arrow_right),
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
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
              child: const TaskList(),
            ))
          ],
        ),
      ),
      floatingActionButton: MyFloatingActionButton(),
    );
  }
}

class MyFloatingActionButton extends StatefulWidget {
  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  bool showFab = true;

  @override
  Widget build(BuildContext context) {
    return showFab
        ? FloatingActionButton(
            onPressed: () {
              final PersistentBottomSheetController<dynamic>
                  bottomSheetController = showBottomSheet<dynamic>(
                context: context,
                builder: (BuildContext context) => BottomSheetWidget(),
              );
              showFoatingActionButton(false);
              bottomSheetController.closed.then((dynamic value) {
                showFoatingActionButton(true);
              });
            },
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          )
        : Container();
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }
}

class BottomSheetWidget extends StatefulWidget {
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  String name;
  int quantity;
  int unit = 0;
  String repeatingDays;
  List<bool> daysToRepeat = <bool>[true, true, true, true, true, true, true];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 4),
      ),
      height: height / 2 > 308 ? 308 : height / 2,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
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
              controller: nameController,
            ),
            const SizedBox(height: 10),
            TextField(
              textAlignVertical: TextAlignVertical.bottom,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Amount',
              ),
              controller: quantityController,
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
                          unit = 0;
                        });
                      },
                      child: Text(
                        'times',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: unit == 0
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          unit = 1;
                        });
                      },
                      child: Text(
                        'minutes',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: unit == 1
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          unit = 2;
                        });
                      },
                      child: Text(
                        'hours',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: unit == 2
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Cancel'),
                ),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      name = nameController.text;
                      quantity = int.parse(quantityController.text);
                      repeatingDays = getRepeatingDaysInBinary(daysToRepeat);

                      if (name == null) {
                        print('Please enter a name.');
                        return;
                      }

                      Provider.of<TaskData>(context, listen: false).addTask(
                          Task(tasks.length, name, quantity, unit, false,
                              repeatingDays, quantity, 'Insert Memo', 0, 0));

                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
