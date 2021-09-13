import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/domain/todo/models/todo.model.dart';
import 'package:mobile/presentation/home/controllers/home.controller.dart';
import 'package:mobile/presentation/text_field/text_field.widget.dart';
import 'package:mobile/presentation/text_field/text_field_type.enum.dart';

import 'button_main.widget.dart';

// ignore: must_be_immutable
class DialogFormWidget extends GetView<HomeController> {
  final TodoModel toDoModel;

  DialogFormWidget({@required this.toDoModel});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Container(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.close,
                          size: 15,
                        ),
                      ),
                    ),
                    Text(
                      'Cadastrar um novo Todo',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFieldWidget(
                      label: 'Descrição',
                      type: TextFieldType.TEXT,
                      value: toDoModel.descricao,
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      label: 'Data',
                      type: TextFieldType.DATE,
                      value: toDoModel.data,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                ButtonMainWidget(
                  onPressed: () {
                    controller.salvarTodo(
                      todoModel: toDoModel,
                      showSnackbar: true,
                    );
                  },
                  texto: 'CADASTRAR',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
