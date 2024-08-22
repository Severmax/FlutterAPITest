import 'package:untitled3/domain/models/field.dart';

import 'cell.dart';

class Task {
  final String id;
  final Cell start;
  final Cell goal;
  final Field field;

  Task({required this.id, required this.start, required this.goal, required this.field});
}