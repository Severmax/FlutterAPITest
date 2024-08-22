import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../domain/models/cell.dart';
import '../domain/models/task.dart';
import '../domain/models/task_result.dart';

class PreviewScreen extends StatelessWidget {
  final Task task;
  final TaskResult result;

  const PreviewScreen({required this.task, required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    final field = task.field; // Используем поле из задачи
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview screen', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
        ),
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(
        builder: (context, constraints){
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.55,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: field.cells[0].length, // Количество столбцов в сетке
                  ),
                  itemCount: field.cells.length * field.cells[0].length, // Общее количество элементов
                  itemBuilder: (context, index) {
                    int row = index ~/ field.cells[0].length;
                    int col = index % field.cells[0].length;
                    final cell = field.cells[row][col];
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _getCellColor(cell, row, col),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text('(${row}, ${col})',
                        style: TextStyle(
                          color: cell.isBlocked ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16), // Добавляем отступ между GridView и текстом
              Text(result.path),
            ],
          );
        },
      ),
    );
  }

  Color _getCellColor(Cell cell, int row, int col) {
    if (task.start.x == row && task.start.y == col) {
      return Color.fromARGB(255, 100, 255, 218); // Цвет для начальной ячейки
    } else if (task.goal.x == row && task.goal.y == col) {
      return Color.fromARGB(255,0,150,136); // Цвет для конечной ячейки
    } else if (result.steps.any((step) => step.x == row && step.y == col)) {
      return Color.fromARGB(255, 76, 175, 80); // Цвет для ячейки, входящей в путь
    }else if (cell.isBlocked) {
      return Colors.black; // Цвет для заблокированной ячейки
    } else {
      return Colors.white; // Цвет по умолчанию
    }
  }
}
