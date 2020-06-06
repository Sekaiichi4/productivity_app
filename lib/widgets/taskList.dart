import 'package:flutter/material.dart';
import 'package:productivity_helper/models/taskData.dart';
import 'package:productivity_helper/widgets/taskTile.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return TaskTile(
            tileIndex: index,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 5,),
        itemCount: Provider.of<TaskData>(context).filteredTasksCount);
  }
}
