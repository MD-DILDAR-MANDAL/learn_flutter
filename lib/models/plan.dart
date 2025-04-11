import './task.dart';

class Plan{
  const Plan({this.name='', this.tasks = const []});
  
  final String name;
  final List<Task> tasks;

  int get completedCount => tasks
  .where((task) => task.complete)
  .length;

  String get completenessMessage => '$completedCount out of ${tasks.length} tasks';

}

