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
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: IconSlideAction(
                caption: '-5',
                color: Colors.green.shade800,
                icon: Icons.remove,
                onTap: () {
                  tasks[filteredTasks[tileIndex].id].currentQuantity -= 5;
                  Provider.of<TaskData>(context, listen: false).updateTask(
                      tasks[filteredTasks[tileIndex].id],
                      filteredTasks[tileIndex].id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: IconSlideAction(
                caption: '-1',
                color: Colors.green.shade400,
                icon: Icons.remove,
                onTap: () {
                  tasks[filteredTasks[tileIndex].id].currentQuantity--;
                  Provider.of<TaskData>(context, listen: false).updateTask(
                      tasks[filteredTasks[tileIndex].id],
                      filteredTasks[tileIndex].id);
                },
              ),
            ),
          ],
          secondaryActions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: IconSlideAction(
                caption: '+1',
                color: Colors.red.shade400,
                icon: Icons.add,
                onTap: () {
                  tasks[filteredTasks[tileIndex].id].currentQuantity++;
                  Provider.of<TaskData>(context, listen: false).updateTask(
                      tasks[filteredTasks[tileIndex].id],
                      filteredTasks[tileIndex].id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: IconSlideAction(
                caption: '+5',
                color: Colors.red.shade800,
                icon: Icons.add,
                onTap: () {
                  tasks[filteredTasks[tileIndex].id].currentQuantity += 5;
                  Provider.of<TaskData>(context, listen: false).updateTask(
                      tasks[filteredTasks[tileIndex].id],
                      filteredTasks[tileIndex].id);
                },
              ),
            ),
          ],
          child: Card(
            child: Container(
              height: dayOffset != 0 ? 56 : 100,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                        // '${currentTask.id} ${currentTask.name} ${currentTask.repeatingDays}'),
                        '${currentTask.name}'),
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
                                  icon: Icon(Icons.play_arrow),
                                  onPressed: () {
                                    print('start timer');
                                    Provider.of<TaskData>(context,
                                            listen: false)
                                        .setActiveTask(
                                            filteredTasks[tileIndex].id);

                                    Navigator.push<dynamic>(context,
                                        MaterialPageRoute<dynamic>(
                                            builder: (BuildContext context) {
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
          ),
        );
      },
    );
  }
}
