import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/task_repository_impl.dart';
import '../models/task.dart';
import '../models/task_result.dart';
import '../usecases/bfs.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository repository;

  TaskCubit(this.repository) : super(TaskInitial());

  Future<void> fetchTasks() async {
    try {
      emit(TaskProgress(0.2 ));
      final tasks = await repository.getTasks();
      final results = <TaskResult>[];
      for (int i = 0; i < tasks.length; i++) {
        final bfs = BFS(tasks[i]);
        final result = bfs.findShortestPath();
        results.add(result);
        print(result.id);
        print(result.path);
        for (final step in result.steps) {
          print('(${step.x},${step.y})');
        }
        emit(TaskProgress((i + 1) / tasks.length));
        await Future.delayed(Duration(seconds: 1));

      }
      emit(TaskResultsLoaded(tasks, results));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> submitTaskResults(List<TaskResult> results) async {
    try {
      emit(TaskProgress(0.2));
      await repository.submitTaskResults(results);
      emit(TaskProgress(0.4));
      await Future.delayed(Duration(seconds: 1));
      emit(TaskProgress(0.7));
      await Future.delayed(Duration(seconds: 1));
      emit(TaskResultsSubmitted());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}