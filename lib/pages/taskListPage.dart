import 'package:flutter/material.dart';
import 'package:productivity_helper/models/task.dart';
import 'package:productivity_helper/models/taskData.dart';
import 'package:productivity_helper/pages/taskCreatePage.dart';
import 'package:productivity_helper/widgets/taskList.dart';
import 'package:provider/provider.dart';

import '../globals.dart';
import 'package:productivity_helper/customColors.dart' as cc;

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
    dayOffset = 0;
    setToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TaskData>(context, listen: false).getTasks();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: cc.black,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: cc.black,
      ),
      body: Container(
        color: cc.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150,
              child: Stack(children: <Widget>[
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      //DAY SELECT CONTAINER
                      decoration: BoxDecoration(
                        color: cc.whiteTrans10,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      height: 120,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                                // color: Colors.purple,
                                ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    //SPACER
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dayOffset = 0;
                                          setToday();
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: cc.black,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: dayOffset == 0
                                                ? Border.all(color: cc.yellow)
                                                : null),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Text>[
                                            Text(
                                              getWeekdayInString(0)
                                                  .substring(0, 3),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                            Text(
                                              getMonthdayInString(0),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    //SPACER
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dayOffset = 1;
                                          setToday();
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: cc.black,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: dayOffset == 1
                                                ? Border.all(color: cc.yellow)
                                                : null),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Text>[
                                            Text(
                                              getWeekdayInString(1)
                                                  .substring(0, 3),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                            Text(
                                              getMonthdayInString(1),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    //SPACER
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dayOffset = 2;
                                          setToday();
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: cc.black,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: dayOffset == 2
                                                ? Border.all(color: cc.yellow)
                                                : null),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Text>[
                                            Text(
                                              getWeekdayInString(2)
                                                  .substring(0, 3),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                            Text(
                                              getMonthdayInString(2),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    //SPACER
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dayOffset = 3;
                                          setToday();
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: cc.black,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: dayOffset == 3
                                                ? Border.all(color: cc.yellow)
                                                : null),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Text>[
                                            Text(
                                              getWeekdayInString(3)
                                                  .substring(0, 3),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                            Text(
                                              getMonthdayInString(3),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    //SPACER
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dayOffset = 4;
                                          setToday();
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: cc.black,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: dayOffset == 4
                                                ? Border.all(color: cc.yellow)
                                                : null),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Text>[
                                            Text(
                                              getWeekdayInString(4)
                                                  .substring(0, 3),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                            Text(
                                              getMonthdayInString(4),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    //SPACER
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dayOffset = 5;
                                          setToday();
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: cc.black,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: dayOffset == 5
                                                ? Border.all(color: cc.yellow)
                                                : null),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Text>[
                                            Text(
                                              getWeekdayInString(5)
                                                  .substring(0, 3),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                            Text(
                                              getMonthdayInString(5),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    //SPACER
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dayOffset = 6;
                                          setToday();
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: cc.black,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: dayOffset == 6
                                                ? Border.all(color: cc.yellow)
                                                : null),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Text>[
                                            Text(
                                              getWeekdayInString(6)
                                                  .substring(0, 3),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                            Text(
                                              getMonthdayInString(6),
                                              style:
                                                  TextStyle(color: cc.yellow),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    //SPACER
                                    flex: 1,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                        ],
                      ),
                      // child: Center(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       IconButton(
                      //         icon: const Icon(Icons.arrow_left),
                      //         color:
                      //             dayOffset != 0 ? Colors.white : Colors.blue,
                      //         onPressed: () {
                      //           //
                      //           if (dayOffset != 0) {
                      //             setState(() {
                      //               dayOffset--;
                      //             });
                      //           }
                      //         },
                      //       ),
                      //       Text(getTodayInString()),
                      //       IconButton(
                      //         icon: const Icon(Icons.arrow_right),
                      //         color:
                      //             dayOffset != 6 ? Colors.white : Colors.blue,
                      //         onPressed: () {
                      //           //
                      //           if (dayOffset != 6) {
                      //             setState(() {
                      //               dayOffset++;
                      //             });
                      //           }
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),
                  ],
                ),
                Container(
                  child: Center(
                    heightFactor: 1,
                    child: Text(
                      '$currentDayTitle',
                      style: TextStyle(
                          color: cc.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 15, bottom: 80),
                color: cc.black,
                child: const TaskList(),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
    return FloatingActionButton(
      foregroundColor: cc.black,
      backgroundColor: cc.yellow,
      onPressed: () {
        Navigator.push<dynamic>(context,
            MaterialPageRoute<dynamic>(builder: (BuildContext context) {
          return const TaskCreatePage();
        }));
      },
      tooltip: 'Add Task',
      child: const Icon(Icons.add),
    );
  }
}
