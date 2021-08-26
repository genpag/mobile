import 'package:meta/meta.dart';
import 'package:mobile/features/home/home.dart';

class TaskModel {
  String id;
  bool isDone;

  final String title;
  final String description;
  final DateTime createdAt;

  TaskModel({
    this.id,
    @required this.isDone,
    @required this.title,
    @required this.description,
    @required this.createdAt,
  });

  TaskEntity toEntity() {
    return TaskEntity(
        id: id,
        isDone: isDone,
        title: title,
        description: description,
        createdAt: createdAt);
  }
}
