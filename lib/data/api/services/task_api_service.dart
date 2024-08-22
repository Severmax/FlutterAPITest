import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/cell.dart';
import '../../../domain/models/field.dart';
import '../../../domain/models/task.dart';
import '../../../domain/models/task_result.dart';

class TaskApiService{
  final String urlAPI;
  final Dio dio;

  TaskApiService(this.urlAPI) : dio = Dio(
    BaseOptions(
      validateStatus: (status) => true,// Игнорировать все ошибки клиента, но не сервера
    ),
  );


  Future<List<Task>> fetchTasks() async {
    final response = await dio.get(urlAPI);

    if (response.statusCode == 200) {
      final data = response.data;
      if (data['error'] == false) {
        final tasksData = data['data'] as List;
        return tasksData.map((taskData) {
          final field = (taskData['field'] as List<dynamic>).map((row) {
            return (row as String).split('').map((cell) => Cell(
              x: row.indexOf(cell),
              y: taskData['field'].indexOf(row),
              isBlocked: cell == 'X',
            )).toList();
          }).toList();

          return Task(
            id: taskData['id'],
            start: Cell(x: taskData['start']['x'], y: taskData['start']['y'], isBlocked: false),
            goal: Cell(x: taskData['end']['x'], y: taskData['end']['y'], isBlocked: false),
            field: Field(cells: field),
          );
        }).toList();
      } else {
        throw Exception('Error fetching tasks: ${data['message']}');
      }
    } else {
      throw Exception('Failed to load tasks');
    }
  }



  Future<void> sendTaskResults(List<TaskResult> results) async {
    final data = jsonEncode(results.map((result) {
      return {
        'id': result.id,
        'result': {
          'steps': result.steps.map((cell) => {'x': cell.x.toString(), 'y': cell.y.toString()}).toList(),
          'path': result.path,
        },
      };
    }).toList());

    debugPrint("$data");

    final response = await dio.post(
      urlAPI,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: data
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send task results ${response.statusMessage}');
    }
  }
}