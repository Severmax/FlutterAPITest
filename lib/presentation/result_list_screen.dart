import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:untitled3/presentation/preview_screen.dart';

import '../domain/models/task.dart';
import '../domain/models/task_result.dart';

class ResultListScreen extends StatelessWidget {
  final List<Task> tasks;
  final List<TaskResult> results;

  ResultListScreen({required this.tasks, required this.results, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list screen', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PreviewScreen(task: tasks[index], result: result,))
              );
            },
            child: ListTile(
              title: Center(child: Text(result.path, style: TextStyle(fontWeight: FontWeight.bold),)),
            ),
          );
        },
      ),
    );
  }
}
