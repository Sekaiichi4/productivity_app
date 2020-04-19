import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productivity_helper/models/task.dart';
import 'package:productivity_helper/models/taskData.dart';
import '../globals.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({Key key, @required this.currentTask}) : super(key: key);

  final Task currentTask;

  @override
  _TaskEditPageState createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  String newName;
  int newQuantity;
  int newUnit;
  String newRepeatingDays;
  List<bool> daysToRepeat = <bool>[];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void editTask(BuildContext context) {
    newName = nameController.text;
    newQuantity = int.parse(quantityController.text);
    newRepeatingDays = getRepeatingDaysInBinary(daysToRepeat);

    if (newName == null) {
      print('Please enter a name.');
      return;
    }

    print(
        'new values are name: $newName, quantity: $newQuantity, repeatingdays: $newRepeatingDays');

    Provider.of<TaskData>(context, listen: false).updateTask(
        Task(
            widget.currentTask.id,
            newName,
            newQuantity,
            newUnit,
            widget.currentTask.cleared,
            newRepeatingDays,
            widget.currentTask.currentQuantity > newQuantity
                ? newQuantity
                : widget.currentTask.currentQuantity),
        widget.currentTask.id);

    Navigator.pop(context);
  }

  @override
  void initState() {
    nameController.text = widget.currentTask.name;
    quantityController.text = widget.currentTask.quantity.toString();

    newUnit = widget.currentTask.unit;
    daysToRepeat = getRepeatingDaysInList(widget.currentTask.repeatingDays);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit ${widget.currentTask.name}',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            iconSize: 24.0,
            color: Colors.green,
            tooltip: 'Save',
            onPressed: () {
              editTask(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              TextField(
                textAlignVertical: TextAlignVertical.bottom,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter a task',
                ),
                controller: nameController,
              ),
              const SizedBox(height: 10),
              TextField(
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Amount',
                ),
                controller: quantityController,
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
                            newUnit = 0;
                          });
                        },
                        child: Text(
                          'times',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: newUnit == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            newUnit = 1;
                          });
                        },
                        child: Text(
                          'minutes',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: newUnit == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            newUnit = 2;
                          });
                        },
                        child: Text(
                          'hours',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: newUnit == 2
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
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[0] = !daysToRepeat[0];
                        });
                      },
                      child: Text(
                        'M',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[0]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[1] = !daysToRepeat[1];
                        });
                      },
                      child: Text(
                        'T',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[1]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[2] = !daysToRepeat[2];
                        });
                      },
                      child: Text(
                        'W',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[2]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[3] = !daysToRepeat[3];
                        });
                      },
                      child: Text(
                        'T',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[3]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[4] = !daysToRepeat[4];
                        });
                      },
                      child: Text(
                        'F',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[4]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[5] = !daysToRepeat[5];
                        });
                      },
                      child: Text(
                        'S',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[5]
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          daysToRepeat[6] = !daysToRepeat[6];
                        });
                      },
                      child: Text(
                        'S',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: daysToRepeat[6]
                                ? FontWeight.bold
                                : FontWeight.normal),
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
