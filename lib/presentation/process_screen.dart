import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/domain/cubit/task_cubit.dart';
import 'package:untitled3/domain/models/task_result.dart';
import 'package:untitled3/presentation/result_list_screen.dart';

import '../data/api/services/task_api_service.dart';
import '../data/repositories/task_repository_impl.dart';
import '../domain/models/task.dart';

class ProcessScreen extends StatelessWidget {
  final String urlAPI;

  const ProcessScreen({required this.urlAPI, super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = [];
    List<TaskResult> results = [];
    return RepositoryProvider(
      create: (context) => TaskRepository(TaskApiService(urlAPI)),
      child: BlocProvider(
        create: (context) => TaskCubit(context.read<TaskRepository>()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Process screen',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blue,
          ),
          body: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is TaskResultsSubmitted) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResultListScreen(
                          tasks: tasks,
                          results: results,
                        )));
              }
            },
            builder: (context, state) {
              if (state is TaskInitial) {
                context.read<TaskCubit>().fetchTasks();
                return SizedBox(
                  width: 10,
                );
              } else if (state is TaskProgress) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Text(
                            'Calculating...',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${(state.progress * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                              value: state.progress,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style,
                          onPressed: null, // Кнопка неактивна
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Send results to server',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is TaskResultsLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    const Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            'All calculation has finished, you can send your results to server',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '100%',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                              value: 1.0,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style,
                          onPressed: () {
                            results = state.results;
                            tasks = state.tasks;
                            context
                                .read<TaskCubit>()
                                .submitTaskResults(results);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Send results to server',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is TaskError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
