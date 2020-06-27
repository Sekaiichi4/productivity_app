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
  String memo;
  bool nameNotGood = false, amountNotGood = false, dayNotGood = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController minuteController = TextEditingController();
  final TextEditingController memoController = TextEditingController();

  int changeIntoMinutes(String hours, String minutes) {
    int result = 0;
    if (hours.isNotEmpty) {
      result += int.parse(hours) * 60;
    }
    if (minutes.isNotEmpty) {
      result += int.parse(minutes);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    // return Material();
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
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '   Name',
                  style: TextStyle(
                    color: nameNotGood ? cc.orange : cc.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 5),
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
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '   My goal',
                  style: TextStyle(
                    color: amountNotGood ? cc.orange : cc.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: cc.whiteTrans10,
                      ),
                      child: TextField(
                        onTap: () {
                          hourController.clear();
                          minuteController.clear();
                          unit = 0;
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        cursorColor: cc.yellow,
                        style: TextStyle(color: cc.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
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
                  ),
                  Container(
                    child: Text(
                      '   times   ',
                      style: TextStyle(
                        color: cc.yellow,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '-------------------------------- or --------------------------------',
                style: TextStyle(
                  color: cc.white,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: cc.whiteTrans10,
                      ),
                      child: TextField(
                        onTap: () {
                          quantityController.clear();
                          unit = 1;
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        cursorColor: cc.yellow,
                        style: TextStyle(color: cc.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(23.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cc.yellow,
                            ),
                            borderRadius: BorderRadius.circular(23.0),
                          ),
                          hintStyle: TextStyle(color: cc.whiteTrans20),
                          hintText: 'Hours',
                        ),
                        controller: hourController,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      ' hr ',
                      style: TextStyle(
                        color: cc.yellow,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: cc.whiteTrans10,
                      ),
                      child: TextField(
                        onTap: () {
                          quantityController.clear();
                          unit = 1;
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        cursorColor: cc.yellow,
                        style: TextStyle(color: cc.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(23.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cc.yellow,
                            ),
                            borderRadius: BorderRadius.circular(23.0),
                          ),
                          hintStyle: TextStyle(color: cc.whiteTrans20),
                          hintText: 'Minutes',
                        ),
                        controller: minuteController,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      ' mins ',
                      style: TextStyle(
                        color: cc.yellow,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '   Choose days',
                  style: TextStyle(
                    color: dayNotGood ? cc.orange : cc.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 5),
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
                        children: <Widget>[
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
                        children: <Widget>[
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
                        children: <Widget>[
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
                        children: <Widget>[
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
                        children: <Widget>[
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
                        children: <Widget>[
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
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '   Memo',
                  style: TextStyle(
                    color: cc.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: cc.whiteTrans10,
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
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
                  controller: memoController,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        //SET NAME
                        if (nameController.text.isEmpty) {
                          print('Please enter a name.');
                          nameNotGood = true;
                          return;
                        } else {
                          nameNotGood = false;
                          name = nameController.text;
                        }

                        //SET AMOUNT
                        if (quantityController.text.isEmpty) {
                          if (hourController.text.isEmpty) {
                            if (minuteController.text.isEmpty) {
                              print('Please enter an amount.');
                              amountNotGood = true;
                              return;
                            } else {
                              amountNotGood = false;
                            }
                          } else {
                            amountNotGood = false;
                          }
                        } else {
                          amountNotGood = false;
                        }

                        if (!amountNotGood) {
                          if (unit == 0) {
                            quantity = int.parse(quantityController.text);
                          } else if (unit == 1) {
                            quantity = changeIntoMinutes(
                                hourController.text, minuteController.text);
                          }
                        }

                        //SET DAY
                        repeatingDays = getRepeatingDaysInBinary(daysToRepeat);

                        if (repeatingDays == '0000000') {
                          print('Please choose a day.');
                          dayNotGood = true;
                          return;
                        } else {
                          dayNotGood = false;
                        }

                        //SET MEMO
                        if (memoController.text.isEmpty) {
                          memo = 'No Memo';
                        } else {
                          memo = memoController.text;
                        }

                        Provider.of<TaskData>(context, listen: false).addTask(
                            Task(tasks.length, name, quantity, unit, false,
                                repeatingDays, 0, memo, 0, 0));

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
