import 'cell.dart';

class TaskResult {
  final String id;
  final List<Cell> steps;
  final String path;

  TaskResult({required this.id, required this.steps, required this.path});

}
