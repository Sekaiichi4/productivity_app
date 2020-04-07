import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task(this.id, this.name, this.quantity, this.unit, this.cleared, this.repeatingDays);

  @HiveField(0)
  int id;
  //name of the task
  @HiveField(1)
  String name;
  //How much of this task needs to be done
  @HiveField(2)
  int quantity;
  //0 times, 1 minutes, 2 hours
  @HiveField(3)
  int unit;
  //task cleared for today
  @HiveField(4)
  bool cleared;
  //repeating days in binary representation MTWTFSS, 1000000 = only monday.
  @HiveField(5)
  String repeatingDays;
}
