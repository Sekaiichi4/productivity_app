import 'package:flutter/material.dart';
import 'package:productivity_helper/globals.dart';
import 'package:productivity_helper/pages/taskEditPage.dart';
import 'package:provider/provider.dart';

import 'package:productivity_helper/models/taskData.dart';
import 'package:productivity_helper/models/task.dart';

class TaskViewPage extends StatelessWidget {
  const TaskViewPage({Key key}) : super(key: key);

  void deleteConfirmation(BuildContext context, Task currentTask) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Are you sure?',
            style: TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are about to delete ${currentTask.name}'),
                const SizedBox(
                  height: 10.0,
                ),
                const Text('This action cannot be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                print('Deleting ${currentTask.name}');
                Provider.of<TaskData>(context, listen: false)
                    .deleteTask(currentTask.id);

                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
              },
              child: const Text(
                'DELETE',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
              },
              child: const Text(
                'CANCEL',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, TaskData taskData, Widget child) {
        final Task currentTask = taskData.getActiveTask();
        final List<bool> daysToRepeat =
            getRepeatingDaysInList(currentTask.repeatingDays);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              currentTask?.name,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.create),
                iconSize: 24.0,
                color: Colors.green,
                tooltip: 'Edit',
                onPressed: () {
                  print('Selected to edit');
                  Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) {
                    return TaskEditPage(currentTask: currentTask);
                  }));
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                iconSize: 24.0,
                color: Colors.red,
                tooltip: 'Delete',
                onPressed: () {
                  print('Selected to deletion');
                  deleteConfirmation(context, currentTask);
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 36.0,
                    color: Colors.grey[300],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Text>[
                        const Text(
                          ' Quantity',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        Text(
                          '${currentTask?.quantity.toString()} ',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 36.0,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          ' Unit',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        Text(
                          '${getUnitName(currentTask?.unit)} ',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 36.0,
                    color: Colors.grey[300],
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            onPressed: () {},
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
                            onPressed: () {},
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
                            onPressed: () {},
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
                            onPressed: () {},
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
                            onPressed: () {},
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
                            onPressed: () {},
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
                            onPressed: () {},
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
