import 'package:flutter/material.dart';
import 'package:productivity_helper/models/task.dart';
import 'package:productivity_helper/models/taskData.dart';
import 'package:productivity_helper/pages/taskViewPage.dart';
import 'package:productivity_helper/pages/taskTimerPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../globals.dart';
import 'package:productivity_helper/customColors.dart' as cc;

class TaskTile extends StatelessWidget {
  const TaskTile({Key key, this.tileIndex}) : super(key: key);

  final int tileIndex;

  void setTopStreak() {
    //Set top streak if or if not null
    if (tasks[filteredTasks[tileIndex].id].topStreak == null) {
      tasks[filteredTasks[tileIndex].id].topStreak =
          tasks[filteredTasks[tileIndex].id].currentStreak;
    } else if (tasks[filteredTasks[tileIndex].id].topStreak <
        tasks[filteredTasks[tileIndex].id].currentStreak) {
      tasks[filteredTasks[tileIndex].id].topStreak =
          tasks[filteredTasks[tileIndex].id].currentStreak;
    }
  }

  Future<void> _showTaskOptions(BuildContext mainContext) async {
    switch (await showDialog<int>(
        context: mainContext,
        builder: (BuildContext context) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: dayOffset == 0 ? 280.0 : 180,
                      maxWidth: 300.0,
                      minWidth: 150.0,
                      minHeight: 150.0),
                  decoration: BoxDecoration(
                    color: cc.black,
                    border: Border.all(
                      color: cc.yellow,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(23)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              child: Text(
                                "I'd like to",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: cc.white, fontSize: 25),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              iconSize: 30,
                              icon: Icon(
                                Icons.close,
                                color: cc.yellow,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                      if (dayOffset == 0)
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 0);
                          },
                          child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: cc.whiteTrans20,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(23)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.check,
                                      color: cc.yellow,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Finish',
                                      style: TextStyle(
                                          color: cc.white, fontSize: 20),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 1);
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: cc.whiteTrans20,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(23)),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.delete,
                                    color: cc.yellow,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        color: cc.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 2);
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: cc.whiteTrans20,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(23)),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.description,
                                    color: cc.yellow,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'View Details',
                                    style: TextStyle(
                                        color: cc.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      if (dayOffset == 0 && filteredTasks[tileIndex].unit == 1)
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 3);
                          },
                          child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: cc.whiteTrans20,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(23)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.timer,
                                      color: cc.yellow,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Open Timer',
                                      style: TextStyle(
                                          color: cc.white, fontSize: 20),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        })) {
      case 0:
        // Finish Task
        updateTaskValue(mainContext, tileIndex, 0, true);
        break;
      case 1:
        // Delete
        final bool doDeleteTask = await showDialog<bool>(
          context: mainContext,
          builder: (BuildContext context) => const DeleteConfirmDialog(),
        );

        if (doDeleteTask) {
          print('Deleting ${filteredTasks[tileIndex].name}');
          Provider.of<TaskData>(mainContext, listen: false)
              .deleteTask(filteredTasks[tileIndex].id);
        }
        break;
      case 2:
        // View Details
        Navigator.push<dynamic>(mainContext,
            MaterialPageRoute<dynamic>(builder: (BuildContext context) {
          return const TaskViewPage();
        }));
        break;
      case 3:
        // Open Timer
        Navigator.push<dynamic>(mainContext,
            MaterialPageRoute<dynamic>(builder: (BuildContext context) {
          return const TaskTimerPage();
        }));
        break;
    }
  }

  Future<void> _showValueSliderDialog(
      BuildContext mainContext, bool isIncreasing, int tileIndex) async {
    // this will contain the result from Navigator.pop(context, result)
    final int selectedAmount = await showDialog<int>(
      context: mainContext,
      builder: (BuildContext context) =>
          ValuePickerDialog(tileIndex: tileIndex, isIncreasing: isIncreasing),
    );

    // execution of this code continues when the dialog was closed (popped)

    // note that the result can also be null, so check it
    // (back button or pressed outside of the dialog)
    if (selectedAmount != null) {
      print('Amount selected is $selectedAmount');
      if (isIncreasing) {
        updateTaskValue(mainContext, tileIndex, selectedAmount, false);
      } else {
        updateTaskValue(mainContext, tileIndex, -selectedAmount, false);
      }
    }
  }

  void updateTaskValue(
      BuildContext mainContext, int tileIndex, int amount, bool doFinishTask) {
    if (doFinishTask) {
      amount = filteredTasks[tileIndex].quantity;
    }

    if (amount < 0) //Subtraction
    {
      if (tasks[filteredTasks[tileIndex].id].currentQuantity <= amount) {
        tasks[filteredTasks[tileIndex].id].currentQuantity = 0;
      } else {
        tasks[filteredTasks[tileIndex].id].currentQuantity += amount;
      }
    } else {
      //Increase
      if (tasks[filteredTasks[tileIndex].id].currentQuantity >=
          tasks[filteredTasks[tileIndex].id].quantity - amount) {
        tasks[filteredTasks[tileIndex].id].currentQuantity =
            tasks[filteredTasks[tileIndex].id].quantity;

        if (!tasks[filteredTasks[tileIndex].id].cleared) {
          tasks[filteredTasks[tileIndex].id].cleared = true;
          if (tasks[filteredTasks[tileIndex].id].currentStreak != null) {
            tasks[filteredTasks[tileIndex].id].currentStreak++;
            setTopStreak();
          } else {
            tasks[filteredTasks[tileIndex].id].currentStreak = 1;
            setTopStreak();
          }
        }
      } else {
        tasks[filteredTasks[tileIndex].id].currentQuantity += amount;
      }
    }

    Provider.of<TaskData>(mainContext, listen: false).updateTask(
        tasks[filteredTasks[tileIndex].id], filteredTasks[tileIndex].id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, TaskData taskData, Widget child) {
        final Task currentTask = taskData.getTask(filteredTasks[tileIndex].id);

        return Slidable(
          enabled: dayOffset == 0,
          actionPane: const SlidableScrollActionPane(),
          actionExtentRatio: 0.22,
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: cc.whiteTrans10,
                borderRadius: const BorderRadius.all(Radius.circular(23)),
              ),
              child: IconSlideAction(
                caption: '-10',
                color: Colors.transparent,
                foregroundColor: cc.orange,
                icon: Icons.remove,
                onTap: () {
                  updateTaskValue(context, tileIndex, -10, false);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: cc.whiteTrans10,
                borderRadius: const BorderRadius.all(Radius.circular(23)),
              ),
              child: IconSlideAction(
                caption: '-5',
                color: Colors.transparent,
                foregroundColor: cc.orange,
                icon: Icons.remove,
                onTap: () {
                  updateTaskValue(context, tileIndex, -5, false);
                },
              ),
            ),
          ],
          secondaryActions: <Widget>[
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: cc.whiteTrans10,
                borderRadius: const BorderRadius.all(Radius.circular(23)),
              ),
              child: IconSlideAction(
                caption: '+5',
                color: Colors.transparent,
                foregroundColor: cc.green,
                icon: Icons.add,
                onTap: () {
                  updateTaskValue(context, tileIndex, 5, false);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: cc.whiteTrans10,
                borderRadius: const BorderRadius.all(Radius.circular(23)),
              ),
              child: IconSlideAction(
                caption: '+10',
                color: Colors.transparent,
                foregroundColor: cc.green,
                icon: Icons.add,
                onTap: () {
                  updateTaskValue(context, tileIndex, 10, false);
                },
              ),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            height: 80,
            child: Row(
              children: <Widget>[
                if (dayOffset == 0)
                  GestureDetector(
                    child: Container(
                      width: 30,
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: cc.whiteTrans10,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(23)),
                      ),
                      child: IconSlideAction(
                        color: Colors.transparent,
                        foregroundColor: cc.orange,
                        icon: Icons.remove,
                        onTap: () {
                          updateTaskValue(context, tileIndex, -1, false);
                        },
                      ),
                    ),
                    onLongPress: () {
                      _showValueSliderDialog(context, false, tileIndex);
                    },
                  ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // openEditTaskDialog(currentTask);
                      print('Tapped on task with index $tileIndex');
                      Provider.of<TaskData>(context, listen: false)
                          .setActiveTask(filteredTasks[tileIndex].id);

                      _showTaskOptions(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: cc.whiteTrans10,
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            //TOP
                            flex: 1,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    '${currentTask.name}',
                                    style: TextStyle(
                                        color: cc.yellow,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  Text(
                                    dayOffset == 0
                                        ? '${currentTask.currentQuantity}/${currentTask.quantity}'
                                        : '${currentTask.quantity}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: dayOffset == 0
                                          ? currentTask.currentQuantity ==
                                                  currentTask.quantity
                                              ? cc.green
                                              : cc.orange
                                          : cc.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // ListTile(
                          //   title:
                          //   onTap: () {

                          //   },
                          // ),
                          Expanded(
                            // BOTTOM
                            flex: 1,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${currentTask.currentStreak} day(s) streak',
                                    style: TextStyle(
                                      color: cc.yellow,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '${getUnitName(currentTask.unit)}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: dayOffset == 0
                                          ? currentTask.currentQuantity ==
                                                  currentTask.quantity
                                              ? cc.green
                                              : cc.orange
                                          : cc.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  // if (currentTask.unit == 1 && dayOffset == 0)
                                  //   IconButton(
                                  //     splashColor: Colors.transparent,
                                  //     icon: const Icon(Icons.play_arrow),
                                  //     onPressed: () {
                                  //       print('start timer');
                                  //       Provider.of<TaskData>(context,
                                  //               listen: false)
                                  //           .setActiveTask(
                                  //               filteredTasks[tileIndex].id);

                                  //       Navigator.push<dynamic>(context,
                                  //           MaterialPageRoute<dynamic>(
                                  //               builder: (BuildContext context) {
                                  //         return const TaskTimerPage();
                                  //       }));
                                  //     },
                                  //   ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (dayOffset == 0)
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      width: 30,
                      decoration: BoxDecoration(
                        color: cc.whiteTrans10,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(23)),
                      ),
                      child: IconSlideAction(
                        color: Colors.transparent,
                        foregroundColor: cc.green,
                        icon: Icons.add,
                        onTap: () {
                          updateTaskValue(context, tileIndex, 1, false);
                        },
                      ),
                    ),
                    onLongPress: () {
                      _showValueSliderDialog(context, true, tileIndex);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// move the dialog into it's own stateful widget.
// It's completely independent from your page
// this is good practice
class ValuePickerDialog extends StatefulWidget {
  /// initial selection for the slider
  final int tileIndex;
  final bool isIncreasing;

  const ValuePickerDialog({Key key, this.tileIndex, this.isIncreasing})
      : super(key: key);

  @override
  _ValuePickerDialogState createState() => _ValuePickerDialogState();
}

class _ValuePickerDialogState extends State<ValuePickerDialog> {
  /// current selection of the slider
  double _value;

  @override
  void initState() {
    super.initState();
    _value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(
                maxHeight: 200.0,
                maxWidth: 300.0,
                minWidth: 150.0,
                minHeight: 100.0),
            decoration: BoxDecoration(
              color: cc.black,
              border: Border.all(
                color: cc.yellow,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(23)),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          widget.isIncreasing
                              ? 'Add this amount'
                              : 'Subtract this amount',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: cc.white, fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        iconSize: 30,
                        icon: Icon(
                          Icons.close,
                          color: cc.yellow,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    '${_value.toInt()}',
                    textAlign: TextAlign.end,
                    style: TextStyle(color: cc.yellow, fontSize: 25),
                  ),
                ),
                Container(
                  child: Slider(
                    activeColor: cc.yellow,
                    inactiveColor: cc.white,
                    value: _value,
                    min: 0,
                    max: widget.isIncreasing
                        ? (tasks[filteredTasks[widget.tileIndex].id].quantity -
                                tasks[filteredTasks[widget.tileIndex].id]
                                    .currentQuantity)
                            .toDouble()
                        : tasks[filteredTasks[widget.tileIndex].id]
                            .currentQuantity
                            .toDouble(),
                    label: '${_value.toInt()}',
                    onChanged: (double value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, _value.toInt());
                  },
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: cc.whiteTrans20,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(23)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Apply',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: cc.white, fontSize: 20),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DeleteConfirmDialog extends StatefulWidget {
  const DeleteConfirmDialog({Key key}) : super(key: key);

  @override
  _DeleteConfirmDialogState createState() => _DeleteConfirmDialogState();
}

class _DeleteConfirmDialogState extends State<DeleteConfirmDialog> {
  /// current selection of the slider

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(
                maxHeight: 210.0,
                maxWidth: 300.0,
                minWidth: 150.0,
                minHeight: 100.0),
            decoration: BoxDecoration(
              color: cc.black,
              border: Border.all(
                color: cc.yellow,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(23)),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(
                          'Are you sure?',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: cc.white, fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        iconSize: 30,
                        icon: Icon(
                          Icons.close,
                          color: cc.yellow,
                        ),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  alignment: Alignment.center,
                  height: 80,
                  child: Text(
                    "You're about to delete this task forever.",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: cc.white, fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: cc.whiteTrans20,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(23)),
                          ),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: cc.white, fontSize: 20),
                          )),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: cc.whiteTrans20,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(23)),
                          ),
                          child: Text(
                            'Delete',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: cc.orange, fontSize: 20),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
