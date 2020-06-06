import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:productivity_helper/models/task.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:productivity_helper/pages/taskListPage.dart';
import 'package:provider/provider.dart';

import 'models/taskData.dart';
import 'customColors.dart' as cc;

void main() {
  Hive.registerAdapter<Task>(TaskAdapter());

  runApp(const MyApp());
}

Future<void> _initHive() async {
  //Hive Database pre-setup
  final Directory appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  // Hive.registerAdapter(TaskAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (BuildContext context) => TaskData(),
      child: MaterialApp(
        color: cc.yellow,
        debugShowCheckedModeBanner: false,
        title: 'Laurens App',
        // theme: ThemeData(
        // ),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => FutureBuilder<void>(
                future: _initHive(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.error != null) {
                      print(snapshot.error);
                      return const Scaffold(
                        body: Center(
                          child: Text(
                              'Error establishing connection to the database.'),
                        ),
                      );
                    } else {
                      return const TaskListPage();
                    }
                  } else {
                    return const Scaffold(
                      body: Center(
                        child: Text('Getting database.'),
                      ),
                    );
                  }
                },
              ),
        },
      ),
    );
  }
}
