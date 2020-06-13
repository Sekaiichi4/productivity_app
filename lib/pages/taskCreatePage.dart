import 'package:flutter/material.dart';
import 'package:productivity_helper/customColors.dart' as cc;
import 'package:productivity_helper/models/task.dart';
import 'package:productivity_helper/models/taskData.dart';
import 'package:provider/provider.dart';

import '../globals.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({Key key}) : super(key: key);

  @override
  _TaskCreatePageState createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  String name;
  int quantity;
  int unit = 0;
  String repeatingDays;
  List<bool> daysToRepeat = <bool>[true, true, true, true, true, true, true];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cc.black,
        centerTitle: true,
        title: const Text(
          'New Habit',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: cc.black,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: cc.whiteTrans10,
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: cc.yellow,
                  style: TextStyle(color: cc.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: cc.yellow,
                      ),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    hintStyle: TextStyle(color: cc.whiteTrans20),
                    hintText: 'Habit name...',
                  ),
                  controller: nameController,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: cc.whiteTrans10,
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: cc.yellow,
                  style: TextStyle(color: cc.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: cc.yellow,
                      ),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    hintStyle: TextStyle(color: cc.whiteTrans20),
                    hintText: 'Amount',
                  ),
                  controller: quantityController,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            unit = 0;
                          });
                        },
                        child: Text(
                          'times',
                          style: TextStyle(
                              color: cc.yellow,
                              fontSize: 16.0,
                              fontWeight: unit == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            unit = 1;
                          });
                        },
                        child: Text(
                          'minutes',
                          style: TextStyle(
                              color: cc.yellow,
                              fontSize: 16.0,
                              fontWeight: unit == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            unit = 2;
                          });
                        },
                        child: Text(
                          'hours',
                          style: TextStyle(
                              color: cc.yellow,
                              fontSize: 16.0,
                              fontWeight: unit == 2
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          daysToRepeat[0] = !daysToRepeat[0];
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.amber,
                            child: Text(
                              'Mon',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cc.yellow,
                                  fontSize: 11.0,
                                  fontWeight: daysToRepeat[0]
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                          Container(
                              height: 21,
                              width: 21,
                              decoration: daysToRepeat[0]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: cc.yellow,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      border: Border.all(color: cc.yellow),
                                      color: cc.black,
                                    ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          daysToRepeat[1] = !daysToRepeat[1];
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.cyan,
                            child: Text(
                              'Tue',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cc.yellow,
                                  fontSize: 11.0,
                                  fontWeight: daysToRepeat[1]
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                          Container(
                              height: 21,
                              width: 21,
                              decoration: daysToRepeat[1]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: cc.yellow,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      border: Border.all(color: cc.yellow),
                                      color: cc.black,
                                    ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          daysToRepeat[2] = !daysToRepeat[2];
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.amber,
                            child: Text(
                              'Wed',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cc.yellow,
                                  fontSize: 11.0,
                                  fontWeight: daysToRepeat[2]
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                          Container(
                              height: 21,
                              width: 21,
                              decoration: daysToRepeat[2]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: cc.yellow,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      border: Border.all(color: cc.yellow),
                                      color: cc.black,
                                    ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          daysToRepeat[3] = !daysToRepeat[3];
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.cyan,
                            child: Text(
                              'Thu',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cc.yellow,
                                  fontSize: 11.0,
                                  fontWeight: daysToRepeat[3]
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                          Container(
                              height: 21,
                              width: 21,
                              decoration: daysToRepeat[3]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: cc.yellow,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      border: Border.all(color: cc.yellow),
                                      color: cc.black,
                                    ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          daysToRepeat[4] = !daysToRepeat[4];
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.amber,
                            child: Text(
                              'Fri',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cc.yellow,
                                  fontSize: 11.0,
                                  fontWeight: daysToRepeat[4]
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                          Container(
                              height: 21,
                              width: 21,
                              decoration: daysToRepeat[4]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: cc.yellow,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      border: Border.all(color: cc.yellow),
                                      color: cc.black,
                                    ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          daysToRepeat[5] = !daysToRepeat[5];
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.cyan,
                            child: Text(
                              'Sat',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cc.yellow,
                                  fontSize: 11.0,
                                  fontWeight: daysToRepeat[5]
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                          Container(
                              height: 21,
                              width: 21,
                              decoration: daysToRepeat[5]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: cc.yellow,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      border: Border.all(color: cc.yellow),
                                      color: cc.black,
                                    ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          daysToRepeat[6] = !daysToRepeat[6];
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.amber,
                            child: Text(
                              'Sun',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cc.yellow,
                                  fontSize: 11.0,
                                  fontWeight: daysToRepeat[6]
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                          Container(
                              height: 21,
                              width: 21,
                              decoration: daysToRepeat[6]
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: cc.yellow,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      border: Border.all(color: cc.yellow),
                                      color: cc.black,
                                    ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        name = nameController.text;
                        quantity = int.parse(quantityController.text);
                        repeatingDays = getRepeatingDaysInBinary(daysToRepeat);

                        if (name == null) {
                          print('Please enter a name.');
                          return;
                        }

                        Provider.of<TaskData>(context, listen: false).addTask(
                            Task(tasks.length, name, quantity, unit, false,
                                repeatingDays, 0, 'Insert Memo', 0, 0));

                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      height: 46,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: cc.yellow,
                      ),
                      child: const Center(
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
