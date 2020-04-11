import 'package:flutter/material.dart';
import 'package:productivity_helper/models/task.dart';
import 'package:productivity_helper/models/taskData.dart';
import 'package:productivity_helper/pages/taskViewPage.dart';
import 'package:provider/provider.dart';

import '../globals.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key key, this.tileIndex}) : super(key: key);

  final int tileIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, TaskData taskData, child) {
        final Task currentTask = taskData.getTask(filteredTasks[tileIndex].id);

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
                    // openEditTaskDialog(currentTask);
                    print('Tapped on task with index $tileIndex');
                    Provider.of<TaskData>(context, listen: false)
                        .setActiveTask(filteredTasks[tileIndex].id);

                    Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) {
                      return const TaskViewPage();
                    }));
                  },
                ),
                if (dayOffset == 0)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          color: Colors.greenAccent,
                          child: IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              // setState(() {
                              if (tasks[filteredTasks[tileIndex].id]
                                      .currentQuantity >
                                  0) {
                                tasks[filteredTasks[tileIndex].id]
                                    .currentQuantity--;
                                Provider.of<TaskData>(context, listen: false)
                                    .updateTask(
                                        tasks[filteredTasks[tileIndex].id],
                                        filteredTasks[tileIndex].id);
                              }
                              // });
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
                              // setState(() {
                              tasks[filteredTasks[tileIndex].id]
                                  .currentQuantity++;
                              Provider.of<TaskData>(context, listen: false)
                                  .updateTask(
                                      tasks[filteredTasks[tileIndex].id],
                                      filteredTasks[tileIndex].id);
                              // });
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
    );
  }
}
