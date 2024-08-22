part of 'task_cubit.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskProgress extends TaskState {
  final double progress;

  TaskProgress(this.progress);
}

class TaskResultsLoaded extends TaskState {
  final List<TaskResult> results;
  final List<Task> tasks;



  TaskResultsLoaded(this.tasks, this.results){
    debugPrint('//////////RESULT////////');
    for (final result in this.results){
      debugPrint(result.id);
      debugPrint(result.path);
      for (final step in result.steps)
        debugPrint("\(${step.x}.${step.y}\)");
    }

    debugPrint('///////////////////////');
  }
}

class TaskResultsSubmitted extends TaskState {}

class TaskError extends TaskState {
  final String message;


  TaskError(this.message){
    debugPrint('//////////ERROR////////');
    debugPrint(this.message);
    debugPrint('///////////////////////');
  }
}