import 'package:flutter/src/widgets/icon_data.dart';

class TaskModel {
  int id = 0;
  String descricao = "";
  int isFinished = 0;

  TaskModel({
    this.id,
    this.descricao,
    this.isFinished
  });

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'isFinished': isFinished
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return TaskModel(id: map['id'], descricao: map['descricao'], isFinished: map['isFinished']);
  }

}