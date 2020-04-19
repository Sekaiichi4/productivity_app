import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

import 'package:productivity_helper/models/taskData.dart';
import 'package:productivity_helper/models/task.dart';

import '../globals.dart';

class TaskTimerPage extends StatelessWidget {
  const TaskTimerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, TaskData taskData, Widget child) {
        final Task currentTask = taskData.getActiveTask();

        void updateTime(int min, int sec) {
          if (min != tasks[currentTask.id].currentQuantity) {
            if (sec == 0) {
              tasks[currentTask.id].currentQuantity = min;
              Provider.of<TaskData>(context, listen: false)
                  .updateTask(tasks[currentTask.id], currentTask.id);
            }
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Timer',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Countdown(
                    duration: Duration(minutes: currentTask.currentQuantity),
                    builder: (BuildContext ctx, Duration remaining) {
                      updateTime(remaining.inMinutes, remaining.inSeconds % 60);
                      return Text(
                        '${remaining.inMinutes}:${remaining.inSeconds % 60}',
                        style: const TextStyle(fontSize: 36),
                      ); // 01:00:00
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
