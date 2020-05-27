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

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, TaskData taskData, Widget child) {
        final Task currentTask = taskData.getTask(filteredTasks[tileIndex].id);

        return Slidable(
          enabled: dayOffset == 0,
          actionPane: const SlidableScrollActionPane(),
          actionExtentRatio: 0.25,
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
                  tasks[filteredTasks[tileIndex].id].currentQuantity += 5;
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
                  tasks[filteredTasks[tileIndex].id].currentQuantity += 10;
                  Provider.of<TaskData>(context, listen: false).updateTask(
                      tasks[filteredTasks[tileIndex].id],
                      filteredTasks[tileIndex].id);
                },
              ),
            ),
          ],
          child: Container(
            height: 100,
            child: Row(
              children: <Widget>[
                if (dayOffset == 0)
                  Container(
                    width: 40,
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: cc.whiteTrans10,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(23),
                          bottomRight: Radius.circular(23)),
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

                      Navigator.push<dynamic>(context,
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) {
                        return const TaskViewPage();
                      }));
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
                                              0 //TODO change 0 to the max value.
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
                                              0 //TODO change 0 to the max value.
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
                    width: 40,
                    decoration: BoxDecoration(
                      color: cc.whiteTrans10,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(23),
                          bottomLeft: Radius.circular(23)),
                    ),
                    child: IconSlideAction(
                      color: Colors.transparent,
                      foregroundColor: cc.green,
                      icon: Icons.add,
                      onTap: () {
                        tasks[filteredTasks[tileIndex].id].currentQuantity++;
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
