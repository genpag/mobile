import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/domain/core/utils/snackbar.util.dart';
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

  Future<void> handleReorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final TodoModel element = todosList.removeAt(oldIndex);
    todosList.insert(newIndex, element);
    todosList.forEach((e) async {
      final ordem = todosList.indexOf(e);
      e.ordem.value = ordem;
      await _toDoDomainService.createOrUpdateTodo(e);
    });
    await popularListTodo();
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
    todosList.sort((a, b) => a.ordem.value.compareTo(b.ordem.value));
  }

  Future<void> salvarTodo({
    TodoModel todoModel,
    bool showSnackbar = false,
  }) async {
    if (todoModel.isValid) {
      await _toDoDomainService.createOrUpdateTodo(todoModel);
      popularListTodo();
      if (showSnackbar) {
        SnackbarUtil.showSuccess(message: 'Cadastro realizado com sucesso.');
      }
    } else {
      SnackbarUtil.showWarning(message: 'Preencha os campos corretamente.');
    }
  }

  Future<void> removeTodo(TodoModel todoModel) async {
    try {
      await _toDoDomainService.removeTodo(value: todoModel);
      popularListTodo();
      SnackbarUtil.showSuccess(message: 'Cadastro removido.');
    } catch (e) {
      SnackbarUtil.showError(
          message: 'Problema interno ao deletar o registro.');
    }
  }
}
