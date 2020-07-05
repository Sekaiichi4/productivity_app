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

  Future<void> _askedToLead(BuildContext mainContext) async {
    switch (await showDialog<int>(
        context: mainContext,
        builder: (BuildContext context) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: Container(
                  constraints: const BoxConstraints(
                      maxHeight: 280.0,
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
        // ...
        break;
      case 1:
        // Delete
        // ...
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
        // ...
        break;
    }
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
                  if (tasks[filteredTasks[tileIndex].id].currentQuantity <=
                      10) {
                    tasks[filteredTasks[tileIndex].id].currentQuantity = 0;
                  } else {
                    tasks[filteredTasks[tileIndex].id].currentQuantity -= 10;
                  }

                  Provider.of<TaskData>(context, listen: false).updateTask(
                      tasks[filteredTasks[tileIndex].id],
                      filteredTasks[tileIndex].id);
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
                  if (tasks[filteredTasks[tileIndex].id].currentQuantity <= 5) {
                    tasks[filteredTasks[tileIndex].id].currentQuantity = 0;
                  } else {
                    tasks[filteredTasks[tileIndex].id].currentQuantity -= 5;
                  }

                  Provider.of<TaskData>(context, listen: false).updateTask(
                      tasks[filteredTasks[tileIndex].id],
                      filteredTasks[tileIndex].id);
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
                  if (tasks[filteredTasks[tileIndex].id].currentQuantity >=
                      tasks[filteredTasks[tileIndex].id].quantity - 5) {
                    tasks[filteredTasks[tileIndex].id].currentQuantity =
                        tasks[filteredTasks[tileIndex].id].quantity;

                    if (!tasks[filteredTasks[tileIndex].id].cleared) {
                      tasks[filteredTasks[tileIndex].id].cleared = true;
                      if (tasks[filteredTasks[tileIndex].id].currentStreak !=
                          null) {
                        tasks[filteredTasks[tileIndex].id].currentStreak++;
                        setTopStreak();
                      } else {
                        tasks[filteredTasks[tileIndex].id].currentStreak = 1;
                        setTopStreak();
                      }
                    }
                  } else {
                    tasks[filteredTasks[tileIndex].id].currentQuantity += 5;
                  }

                  Provider.of<TaskData>(context, listen: false).updateTask(
                      tasks[filteredTasks[tileIndex].id],
                      filteredTasks[tileIndex].id);
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
                  if (tasks[filteredTasks[tileIndex].id].currentQuantity >=
                      tasks[filteredTasks[tileIndex].id].quantity - 10) {
                    tasks[filteredTasks[tileIndex].id].currentQuantity =
                        tasks[filteredTasks[tileIndex].id].quantity;

                    if (!tasks[filteredTasks[tileIndex].id].cleared) {
                      tasks[filteredTasks[tileIndex].id].cleared = true;
                      if (tasks[filteredTasks[tileIndex].id].currentStreak !=
                          null) {
                        tasks[filteredTasks[tileIndex].id].currentStreak++;
                        setTopStreak();
                      } else {
                        tasks[filteredTasks[tileIndex].id].currentStreak = 1;
                        setTopStreak();
                      }
                    }
                  } else {
                    tasks[filteredTasks[tileIndex].id].currentQuantity += 10;
                  }

                  Provider.of<TaskData>(context, listen: false).updateTask(
                      tasks[filteredTasks[tileIndex].id],
                      filteredTasks[tileIndex].id);
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
                  Container(
                    width: 30,
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: cc.whiteTrans10,
                      borderRadius: const BorderRadius.all(Radius.circular(23)),
                    ),
                    child: IconSlideAction(
                      color: Colors.transparent,
                      foregroundColor: cc.orange,
                      icon: Icons.remove,
                      onTap: () {
                        if (tasks[filteredTasks[tileIndex].id]
                                .currentQuantity <=
                            1) {
                          tasks[filteredTasks[tileIndex].id].currentQuantity =
                              0;
                        } else {
                          tasks[filteredTasks[tileIndex].id].currentQuantity--;
                        }

                        Provider.of<TaskData>(context, listen: false)
                            .updateTask(tasks[filteredTasks[tileIndex].id],
                                filteredTasks[tileIndex].id);
                      },
                    ),
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

                      _askedToLead(context);
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
                                    '${currentTask.currentQuantity}/${currentTask.quantity}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: currentTask.currentQuantity ==
                                              currentTask.quantity
                                          ? cc.green
                                          : cc.orange,
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
                                      color: currentTask.currentQuantity ==
                                              currentTask.quantity
                                          ? cc.green
                                          : cc.orange,
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
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    width: 30,
                    decoration: BoxDecoration(
                      color: cc.whiteTrans10,
                      borderRadius: const BorderRadius.all(Radius.circular(23)),
                    ),
                    child: IconSlideAction(
                      color: Colors.transparent,
                      foregroundColor: cc.green,
                      icon: Icons.add,
                      onTap: () {
                        if (tasks[filteredTasks[tileIndex].id]
                                .currentQuantity >=
                            tasks[filteredTasks[tileIndex].id].quantity - 1) {
                          tasks[filteredTasks[tileIndex].id].currentQuantity =
                              tasks[filteredTasks[tileIndex].id].quantity;

                          if (!tasks[filteredTasks[tileIndex].id].cleared) {
                            tasks[filteredTasks[tileIndex].id].cleared = true;
                            if (tasks[filteredTasks[tileIndex].id]
                                    .currentStreak !=
                                null) {
                              tasks[filteredTasks[tileIndex].id]
                                  .currentStreak++;
                              setTopStreak();
                            } else {
                              tasks[filteredTasks[tileIndex].id].currentStreak =
                                  1;
                              setTopStreak();
                            }
                          }
                        } else {
                          tasks[filteredTasks[tileIndex].id].currentQuantity++;
                        }

                        Provider.of<TaskData>(context, listen: false)
                            .updateTask(tasks[filteredTasks[tileIndex].id],
                                filteredTasks[tileIndex].id);
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
