import 'dart:collection';

import '../models/cell.dart';
import '../models/field.dart';
import '../models/task.dart';
import '../models/task_result.dart';

class BFS {
  final Task task;

  BFS(this.task);

  TaskResult findShortestPath() {
    final queue = Queue<List<Cell>>();
    final visited = <Cell>{};

    queue.add([task.start]);
    visited.add(task.start);

    while (queue.isNotEmpty) {
      final path = queue.removeFirst();
      final current = path.last;

      if (current.x == task.goal.x && current.y == task.goal.y) {
        final steps = path.map((cell) => Cell(x: cell.x, y: cell.y)).toList();
        final pathString = steps.map((step) => '(${step.x},${step.y})').join('->');
        return TaskResult(id: task.id, steps: steps, path: pathString);
      }

      for (final neighbor in getNeighbors(current)) {
        if (!visited.contains(neighbor) && !task.field.cells[neighbor.x][neighbor.y].isBlocked) {
          final newPath = List<Cell>.from(path);
          newPath.add(neighbor);
          queue.add(newPath);
          visited.add(neighbor);
        }
      }
    }

    // Если путь не найден, возвращаем пустой результат
    return TaskResult(id: task.id, steps: [], path: '');
  }

  List<Cell> getNeighbors(Cell cell) {
    final neighbors = <Cell>[];
    final x = cell.x;
    final y = cell.y;
    final maxX = task.field.cells.length;
    final maxY = task.field.cells[0].length;

    // Добавляем соседей по горизонтали и вертикали
    if (x > 0) neighbors.add(Cell(x: x-1, y: y));
    if (x < maxX - 1) neighbors.add(Cell(x: x+1, y: y));
    if (y > 0) neighbors.add(Cell(x: x, y: y-1));
    if (y < maxY - 1) neighbors.add(Cell(x: x, y: y+1));

    // Добавляем соседей по диагонали
    if (x > 0 && y > 0) neighbors.add(Cell(x: x-1, y: y-1));
    if (x > 0 && y < maxY - 1) neighbors.add(Cell(x: x-1, y: y+1));
    if (x < maxX - 1 && y > 0) neighbors.add(Cell(x: x+1, y: y-1));
    if (x < maxX - 1 && y < maxY - 1) neighbors.add(Cell(x: x+1, y: y+1));

    return neighbors;
  }
}