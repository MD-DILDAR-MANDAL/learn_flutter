import './task.dart';

class Plan{
  const Plan({this.name='', this.tasks = const []});
  
  final String name;
  final List<Task> tasks;
}