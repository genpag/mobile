import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/domain/todo/models/todo.model.dart';
import 'package:mobile/domain/todo/todo.domain.service.dart';
import 'package:mobile/presentation/home/widgets/dialog_form.widget.dart';

class HomeController extends GetxController {
  final isNaoRealizadasExpanded = false.obs;
  final isRealizadasExpanded = false.obs;
  final todosList = RxList<TodoModel>();
  TodoDomainService _toDoDomainService;
  HomeController({
    @required TodoDomainService toDoDomainService,
  }) {
    _toDoDomainService = toDoDomainService;
  }

  @override
  void onInit() {
    super.onInit();
    popularListTodo();
  }

  void changeIsNaoRealizadasExpanded() {
    isNaoRealizadasExpanded.value = !isNaoRealizadasExpanded.value;
  }

  void changeisRealizadasExpanded() {
    isRealizadasExpanded.value = !isRealizadasExpanded.value;
  }

  void atualizarSequencia(int oldI, int newI) {}

  void abrirForm(TodoModel todoModel) {
    if (todoModel == null) {
      todoModel = TodoModel.blank(ordem: todosList.length);
    }
    Get.dialog(DialogFormWidget(toDoModel: todoModel));
  }

  Future<void> popularListTodo() async {
    todosList.assignAll(await _toDoDomainService.getAllTodo());
  }

  Future<void> salvarTodo(TodoModel todoModel) async {
    await _toDoDomainService.createOrUpdateTodo(todoModel);
    popularListTodo();
  }

  Future<void> removeTodo(TodoModel todoModel) async {
    await _toDoDomainService.removeTodo(value: todoModel);
    popularListTodo();
  }
}
