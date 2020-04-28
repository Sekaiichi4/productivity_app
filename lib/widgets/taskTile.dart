import 'package:flutter/material.dart';
import 'package:productivity_helper/models/task.dart';
import 'package:productivity_helper/models/taskData.dart';
import 'package:productivity_helper/pages/taskViewPage.dart';
import 'package:productivity_helper/pages/taskTimerPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../globals.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key key, this.tileIndex}) : super(key: key);

  final int tileIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, TaskData taskData, child) {
        final Task currentTask = taskData.getTask(filteredTasks[tileIndex].id);

        return Slidable(
          actionPane: const SlidableBehindActionPane(),
          actionExtentRatio: 0.25,
          actions: <Widget>[
            IconSlideAction(
              caption: '-10',
              color: Colors.green.shade800,
              icon: Icons.remove,
              onTap: () {
                if (tasks[filteredTasks[tileIndex].id].currentQuantity <= 10) {
                  tasks[filteredTasks[tileIndex].id].currentQuantity = 0;

                  if (!tasks[filteredTasks[tileIndex].id].cleared) {
                    tasks[filteredTasks[tileIndex].id].cleared = true;
                    if (tasks[filteredTasks[tileIndex].id].currentStreak !=
                        null) {
                      tasks[filteredTasks[tileIndex].id].currentStreak++;
                    } else {
                      tasks[filteredTasks[tileIndex].id].currentStreak = 1;
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
            IconSlideAction(
              caption: '-5',
              color: Colors.green.shade600,
              icon: Icons.remove,
              onTap: () {
                if (tasks[filteredTasks[tileIndex].id].currentQuantity <= 5) {
                  tasks[filteredTasks[tileIndex].id].currentQuantity = 0;

                  if (!tasks[filteredTasks[tileIndex].id].cleared) {
                    tasks[filteredTasks[tileIndex].id].cleared = true;
                    if (tasks[filteredTasks[tileIndex].id].currentStreak !=
                        null) {
                      tasks[filteredTasks[tileIndex].id].currentStreak++;
                    } else {
                      tasks[filteredTasks[tileIndex].id].currentStreak = 1;
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
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: '+5',
              color: Colors.red.shade600,
              icon: Icons.add,
              onTap: () {
                tasks[filteredTasks[tileIndex].id].currentQuantity += 5;
                Provider.of<TaskData>(context, listen: false).updateTask(
                    tasks[filteredTasks[tileIndex].id],
                    filteredTasks[tileIndex].id);
              },
            ),
            IconSlideAction(
              caption: '+10',
              color: Colors.red.shade800,
              icon: Icons.add,
              onTap: () {
                tasks[filteredTasks[tileIndex].id].currentQuantity += 10;
                Provider.of<TaskData>(context, listen: false).updateTask(
                    tasks[filteredTasks[tileIndex].id],
                    filteredTasks[tileIndex].id);
              },
            ),
          ],
          child: Container(
            color: Colors.white,
            height: dayOffset != 0 ? 56 : 100,
            child: Row(
              children: <Widget>[
                if (dayOffset == 0)
                  Container(
                    width: 40,
                    child: IconSlideAction(
                      color: Colors.green.shade400,
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

                              //Set top streak if or if not null
                              if (tasks[filteredTasks[tileIndex].id]
                                      .topStreak ==
                                  null) {
                                tasks[filteredTasks[tileIndex].id].topStreak =
                                    tasks[filteredTasks[tileIndex].id]
                                        .currentStreak;
                              } else if (tasks[filteredTasks[tileIndex].id]
                                      .topStreak <
                                  tasks[filteredTasks[tileIndex].id]
                                      .currentStreak) {
                                tasks[filteredTasks[tileIndex].id].topStreak =
                                    tasks[filteredTasks[tileIndex].id]
                                        .currentStreak;
                              }
                            } else {
                              tasks[filteredTasks[tileIndex].id].currentStreak =
                                  1;

                              //Set top streak if or if not null
                              if (tasks[filteredTasks[tileIndex].id]
                                      .topStreak ==
                                  null) {
                                tasks[filteredTasks[tileIndex].id].topStreak =
                                    1;
                              } else if (tasks[filteredTasks[tileIndex].id]
                                      .topStreak <
                                  1) {
                                tasks[filteredTasks[tileIndex].id].topStreak =
                                    1;
                              }
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
                Expanded(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              '${currentTask.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            Container(
                              width: 20,
                              child: Text(
                                '${currentTask.currentStreak}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
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
                      ),
                      if (dayOffset == 0)
                        Expanded(
                          child: Container(
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      '${currentTask.currentQuantity} ${getUnitName(currentTask.unit)}'),
                                  if (currentTask.unit == 1)
                                    IconButton(
                                      splashColor: Colors.transparent,
                                      icon: const Icon(Icons.play_arrow),
                                      onPressed: () {
                                        print('start timer');
                                        Provider.of<TaskData>(context,
                                                listen: false)
                                            .setActiveTask(
                                                filteredTasks[tileIndex].id);

                                        Navigator.push<dynamic>(context,
                                            MaterialPageRoute<dynamic>(builder:
                                                (BuildContext context) {
                                          return const TaskTimerPage();
                                        }));
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (dayOffset == 0)
                  Container(
                    width: 40,
                    child: IconSlideAction(
                      color: Colors.red.shade400,
                      foregroundColor: Colors.black,
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
