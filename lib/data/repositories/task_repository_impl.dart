import '../../domain/models/task.dart';
import '../../domain/models/task_result.dart';
import '../../domain/repositories/itask_repository.dart';
import '../api/services/task_api_service.dart';

class TaskRepository implements ITaskRepository {
  final TaskApiService apiService;

  TaskRepository(this.apiService);

  @override
  Future<List<Task>> getTasks() async {
    return await apiService.fetchTasks();
  }

  @override
  Future<void> submitTaskResults(List<TaskResult> results) async {
    await apiService.sendTaskResults(results);
  }
}