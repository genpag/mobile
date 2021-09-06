import 'package:flutter/material.dart';

class Todo {
  String description;
  int sequence;
  int id;
  bool completed;

  Todo({@required this.description, @required this.sequence, this.id, this.completed = false});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
      id: json['id'], description: json['description'], completed: json['completed'] == 1, sequence: json['sequence']);

  Map<String, dynamic> toJson() => {
        'description': description,
        'completed': completed ? 1 : 0,
        'sequence': sequence,
      };
}
