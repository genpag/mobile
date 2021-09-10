import 'package:mobile/infrastructure/service/daos/todo.dao.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

import 'models/todo.model.dart';

class TodoDomainService {
  TodoDomainService();

  Future<List<TodoModel>> getAllTodo() async {
    return (await TodoDao().selectAll())
        .map((e) => TodoModel().fromDao(e))
        .toList();
  }

  Future<void> deleteTodo({String id, Function(TodoDao value) where}) async {
    await TodoDao().delete(id: id, where: where);
  }

  Future<void> updateTodo({@required index, @required TodoDao value}) async {
    await TodoDao().update(index: index, value: value);
  }

  Future<void> createTodo(TodoModel todoModel) async {
    try {
      String hash = Uuid().v1();
      await TodoDao().save(id: hash, value: todoModel.toDao());
    } catch (e) {
      print("Erro ao salvar Todo no banco de dados: " + e.toString());
    }
  }
}
