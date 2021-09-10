import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/domain/todo/models/todo.model.dart';
import 'package:mobile/domain/todo/todo.domain.service.dart';
import 'package:mobile/presentation/home/widgets/dialog_form.widget.dart';

class HomeController extends GetxController {
  final isNaoRealizadasExpanded = false.obs;
  final isRealizadasExpanded = false.obs;
  final tasks = RxList<TodoModel>();
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

  void abrirForm() {
    final toDoModel = TodoModel.blank(tasks.length);
    Get.dialog(DialogFormWidget(toDoModel: toDoModel));
  }

  Future<void> popularListTodo() async {
    tasks.assignAll(await _toDoDomainService.getAllTodo());
  }

  Future<void> salvarTodo(TodoModel todoModel) async {
    await _toDoDomainService.createTodo(todoModel);
    popularListTodo();
  }
}
