import 'package:mobile/infrastructure/service/daos/todo.dao.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

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

  Future<void> updateTodo({@required TodoModel todoModel}) async {
    await TodoDao().updateWhere(
      where: (item) => item.id == todoModel.id,
      value: todoModel.toDao(),
    );
  }

  Future<void> removeTodo({@required TodoModel value}) async {
    await TodoDao().delete(
      where: (item) => item.id == value.id,
    );
  }

  Future<void> createOrUpdateTodo(TodoModel todoModel) async {
    try {
      if (todoModel.id == null) {
        createTodo(todoModel: todoModel);
      } else {
        updateTodo(todoModel: todoModel);
      }
    } catch (e) {
      print("Erro ao salvar Todo no banco de dados: " + e.toString());
    }
  }

  Future<void> createTodo({@required TodoModel todoModel}) async {
    try {
      todoModel.id = Uuid().v1();
      await TodoDao().save(id: todoModel.id, value: todoModel.toDao());
    } catch (e) {
      rethrow;
    }
  }
}
