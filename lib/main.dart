import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laurens App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Laurens App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //------------
  //--VARIABLES
  //------------
  List<Task> tasks = <Task>[];

  //Task Editor Screen
  bool showTaskDialog = false;
  TextEditingController taskTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();

  int radioValue;

  //------------
  //--METHODS
  //------------
  void openTaskDialog() {
    if (!showTaskDialog) {
      //Lets create mock items for now
      setState(() {
        taskTextController.clear();
        radioValue = 0;
        showTaskDialog = true;
      });
    }
  }

  String getUnitName(int unit) {
    switch (unit) {
      case 0:
        return 'times';
      case 1:
        return 'minutes';
      case 2:
        return 'hours';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            homeScreen(),
            if (showTaskDialog) taskEditor(),
          ],
        ),
      ),
    );
  }

  Widget homeScreen() {
    return Scaffold(
      body: tasks.isNotEmpty
          ? ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final Task currentTask = tasks[index];
                return Card(
                  child: ListTile(
                    title: Text('${currentTask.name}'),
                    trailing: Text(
                        '${currentTask.quantity} ${getUnitName(currentTask.unit)}'),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: tasks.length)
          : const Center(
              child: Text('Nothing to do... Great!'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openTaskDialog,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget taskEditor() {
    return Container(
      color: Colors.black.withAlpha(200),
      child: AlertDialog(
        title: const Text('Create a Task'),
        content: SingleChildScrollView(
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
                controller: taskTextController,
              ),
              const SizedBox(height: 10),
              TextField(
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Amount',
                ),
                controller: quantityTextController,
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: radioValue,
                    onChanged: (int value) {
                      setState(() {
                        radioValue = value;
                      });
                    },
                  ),
                  const Text(
                    'times',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Radio(
                    value: 1,
                    groupValue: radioValue,
                    onChanged: (int value) {
                      setState(() {
                        radioValue = value;
                      });
                    },
                  ),
                  const Text(
                    'minutes',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Radio(
                    value: 2,
                    groupValue: radioValue,
                    onChanged: (int value) {
                      setState(() {
                        radioValue = value;
                      });
                    },
                  ),
                  const Text(
                    'hours',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                showTaskDialog = false;
              });
            },
            child: const Text('Cancel'),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                print('Added task');
                tasks.add(Task(0, '${taskTextController.text}',
                    int.parse(quantityTextController.text), radioValue, false));
                showTaskDialog = false;
              });
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class Task {
  Task(this.id, this.name, this.quantity, this.unit, this.cleared);

  int id;
  //name of the task
  String name;
  //How much of this task needs to be done
  int quantity;
  //0 times, 1 minutes, 2 hours
  int unit;
  //task cleared for today
  bool cleared;
  //repeating days in binary representation MTWTFSS, 1000000 = only monday.
  int repeatingDays;
}
