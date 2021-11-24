import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/model/to_do.dart';
import 'package:mobile/utils/themes.dart';

class ToDoController extends GetxController {
  RxList<ToDo> todos = <ToDo>[].obs;

  @override
  void onInit() {
    List? storedToDos = GetStorage().read<List>('todos');
    if (!(storedToDos == null)) {
      todos = storedToDos.map((e) => ToDo.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }

  final RxInt _color = 0.obs;
  int? get color => _color.value;
  set color(int? value) => _color.value = value!;
}
