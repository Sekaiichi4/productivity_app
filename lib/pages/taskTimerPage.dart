import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:productivity_helper/models/task.dart';
import 'package:productivity_helper/models/taskData.dart';
import 'package:provider/provider.dart';

import '../customColors.dart' as cc;
import '../globals.dart';

class TaskTimerPage extends StatefulWidget {
  const TaskTimerPage({Key key, @required this.currentTask}) : super(key: key);

  final Task currentTask;

  @override
  _TaskTimerPageState createState() => _TaskTimerPageState();
}

class _TaskTimerPageState extends State<TaskTimerPage> {
  bool notUpdatedYet = false;
  bool isPaused = true;
  Duration remainingTime;

  void updateTime(int min, int sec) {
    if (min != tasks[widget.currentTask.id].currentQuantity) {
      if (sec == 0) {
        tasks[widget.currentTask.id].currentQuantity =
            tasks[widget.currentTask.id].quantity - min;

        if (min == 0) {
          if (!tasks[widget.currentTask.id].cleared) {
            tasks[widget.currentTask.id].cleared = true;
            if (tasks[widget.currentTask.id].currentStreak != null) {
              tasks[widget.currentTask.id].currentStreak++;
              if (tasks[widget.currentTask.id].topStreak == null) {
                tasks[widget.currentTask.id].topStreak = 1;
              } else if (tasks[widget.currentTask.id].topStreak <
                  tasks[widget.currentTask.id].currentStreak) {
                tasks[widget.currentTask.id].topStreak =
                    tasks[widget.currentTask.id].currentStreak;
              }
            } else {
              tasks[widget.currentTask.id].currentStreak = 1;
              if (tasks[widget.currentTask.id].topStreak == null) {
                tasks[widget.currentTask.id].topStreak = 1;
              } else if (tasks[widget.currentTask.id].topStreak < 1) {
                tasks[widget.currentTask.id].topStreak = 1;
              }
            }
          }
        }

        if (notUpdatedYet) {
          notUpdatedYet = false;
          Provider.of<TaskData>(context, listen: false)
              .updateTask(tasks[widget.currentTask.id], widget.currentTask.id);
        }
      } else {
        notUpdatedYet = true;
      }
    }
  }

  @override
  void initState() {
    remainingTime = Duration(
        minutes:
            widget.currentTask.quantity - widget.currentTask.currentQuantity);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                flex: 1,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:40.0),
                      child: Image.asset(
                        'assets/backgrounds/clock.png',
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top:35.0),
                      child: !isPaused
                          ? Countdown(
                              duration: remainingTime,
                              builder: (BuildContext ctx, Duration remaining) {
                                remainingTime = remaining;
                                updateTime(remaining.inMinutes,
                                    remaining.inSeconds % 60);

                                return Text(
                                  '${remaining.inMinutes}:${remaining.inSeconds % 60}',
                                  style:
                                      TextStyle(fontSize: 35, color: cc.black),
                                ); // 01:00:00
                              },
                            )
                          : Text(
                              '${remainingTime.inMinutes}:${remainingTime.inSeconds % 60}',
                              style: TextStyle(fontSize: 35, color: cc.black),
                            ), // 01:00:00
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPaused = !isPaused;
                            print(
                                'isPaused is now $isPaused with remainingTime being $remainingTime');
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isPaused ? cc.green : cc.orange,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(23)),
                            ),
                            child: Text(
                              isPaused ? 'Start/Resume' : 'Pause',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: cc.white, fontSize: 20),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
