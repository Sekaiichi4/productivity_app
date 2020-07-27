import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:productivity_helper/models/task.dart';
import 'package:productivity_helper/models/taskData.dart';
import 'package:provider/provider.dart';

import '../customColors.dart' as cc;
import '../globals.dart';

class TaskTimerPage extends StatelessWidget {
  const TaskTimerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, TaskData taskData, Widget child) {
        final Task currentTask = taskData.getActiveTask();
        bool notUpdatedYet = false;

        void updateTime(int min, int sec) {
          if (min != tasks[currentTask.id].currentQuantity) {
            if (sec == 0) {
              tasks[currentTask.id].currentQuantity =
                  tasks[currentTask.id].quantity - min;

              if (min == 0) {
                if (!tasks[currentTask.id].cleared) {
                  tasks[currentTask.id].cleared = true;
                  if (tasks[currentTask.id].currentStreak != null) {
                    tasks[currentTask.id].currentStreak++;
                    if (tasks[currentTask.id].topStreak == null) {
                      tasks[currentTask.id].topStreak = 1;
                    } else if (tasks[currentTask.id].topStreak <
                        tasks[currentTask.id].currentStreak) {
                      tasks[currentTask.id].topStreak =
                          tasks[currentTask.id].currentStreak;
                    }
                  } else {
                    tasks[currentTask.id].currentStreak = 1;
                    if (tasks[currentTask.id].topStreak == null) {
                      tasks[currentTask.id].topStreak = 1;
                    } else if (tasks[currentTask.id].topStreak < 1) {
                      tasks[currentTask.id].topStreak = 1;
                    }
                  }
                }
              }

              if (notUpdatedYet) {
                notUpdatedYet = false;
                Provider.of<TaskData>(context, listen: false)
                    .updateTask(tasks[currentTask.id], currentTask.id);
              }
            } else {
              notUpdatedYet = true;
            }
          }
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: cc.black,
            centerTitle: true,
            title: const Text(
              'Timer',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            color: cc.black,
            child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Countdown(
                      duration: Duration(
                          minutes: currentTask.quantity -
                              currentTask.currentQuantity),
                      builder: (BuildContext ctx, Duration remaining) {
                        updateTime(
                            remaining.inMinutes, remaining.inSeconds % 60);
                        return Text(
                          '${remaining.inMinutes}:${remaining.inSeconds % 60}',
                          style: TextStyle(fontSize: 54, color: cc.white),
                        ); // 01:00:00
                      },
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
