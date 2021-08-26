import 'dart:convert';

import '../../domain/models/task_model.dart';
import 'package:meta/meta.dart';

class TaskEntity extends TaskModel {
  TaskEntity({
    @required String id,
    @required bool isDone,
    @required String title,
    @required String description,
    @required DateTime createdAt,
  }) : super(
          id: id,
          isDone: isDone,
          title: title,
          description: description,
          createdAt: createdAt,
        );

  factory TaskEntity.fromJson(String source) {
    final map = json.decode(source);
    return TaskEntity(
        id: map['id'],
        isDone: map['isDone'],
        title: map['title'],
        description: map['description'],
        createdAt: DateTime.parse(map['createdAt']));
  }

  factory TaskEntity.fromModel(TaskModel model) {
    return TaskEntity(
      id: model.id,
      isDone: model.isDone,
      title: model.title,
      description: model.description,
      createdAt: model.createdAt,
    );
  }

  String toJson() {
    return json.encode({
      'id': id,
      'isDone': isDone,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    });
  }

  TaskModel toModel() {
    return TaskModel(
        id: id,
        isDone: isDone,
        title: title,
        description: description,
        createdAt: createdAt);
  }
}
