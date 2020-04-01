import 'package:flutter/material.dart';

List<Task> tasks = <Task>[];

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
  void openTaskDialog() {
    //Lets create mock items for now
    setState(() {
      tasks.clear();
      tasks.add(Task(0, 'Push-ups'));
      tasks.add(Task(0, 'Sit-ups'));
    });
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
            tasks.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final Task currentTask = tasks[index];
                      return Card(
                        child: ListTile(
                          title: Text('${currentTask.description}'),
                          trailing: Icon(Icons.more_vert),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: tasks.length)
                : const Center(
                    child: Text('Nothing to do... Great!'),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openTaskDialog,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Task {
  Task(this.id, this.description);

  int id;
  String description;
}
