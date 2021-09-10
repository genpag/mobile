import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/domain/core/interfaces/dao.interface.dart';
import 'package:mobile/domain/core/interfaces/model.interface.dart';
import 'package:mobile/infrastructure/service/daos/todo.dao.dart';

class TodoModel extends Model<TodoModel> {
  final Rx<bool> isRealizado;
  final Rx<int> ordem;
  final RxString descricao;
  final Rx<DateTime> data;
  String id;

  bool get isValid {
    final descricaoValid =
        descricao.value != null && descricao.value.isNotEmpty;
    final dataValid = data.value != null;

    return descricaoValid && dataValid;
  }

  TodoModel({
    this.isRealizado,
    this.ordem,
    this.descricao,
    this.data,
    this.id,
  });

  factory TodoModel.blank({@required int ordem}) {
    return TodoModel(
      isRealizado: Rx(false),
      ordem: Rx(ordem),
      descricao: ''.obs,
      data: Rx<DateTime>(),
    );
  }

  @override
  BaseDao toDao() {
    return TodoDao()
      ..id = this.id
      ..descricao = this.descricao.value
      ..isRealizado = this.isRealizado.value
      ..ordem = this.ordem.value
      ..data = this.data.value;
  }

  @override
  TodoModel fromDao(BaseDao b) {
    TodoDao baseDao = b as TodoDao;
    return TodoModel(
      id: baseDao.id,
      descricao: baseDao.descricao.obs,
      isRealizado: Rx(baseDao.isRealizado),
      ordem: Rx(baseDao.ordem),
      data: Rx(baseDao.data),
    );
  }
}
