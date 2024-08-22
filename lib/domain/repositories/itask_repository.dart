import '../models/task.dart';
import '../models/task_result.dart';

abstract class ITaskRepository {
  Future<List<Task>> getTasks();
  Future<void> submitTaskResults(List<TaskResult> results);
}