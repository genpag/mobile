import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controllers/to_do_controller.dart';
import 'package:mobile/model/to_do.dart';

import 'package:mobile/screens/home_page/widgets/input_filed_widget.dart';
import 'package:mobile/utils/themes.dart';

class ToDoPage extends StatelessWidget {
  final ToDoController toDoController = Get.find<ToDoController>();
  final int? index;

  ToDoPage({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "";
    if (!(this.index == null)) {
      text = toDoController.todos[index!].title!;
    }
    TextEditingController textTitleController =
        TextEditingController(text: text);
    TextEditingController textNoteController =
        TextEditingController(text: text);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Qual a tarefa?'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              InputFiledWidget(
                title: textTitleController.text,
                hint: 'Adicione um titulo',
                controller: textTitleController,
              ),
              InputFiledWidget(
                title: textNoteController.text,
                hint: 'Adicione uma descrição',
                controller: textNoteController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Cancelar')),
                  ElevatedButton(
                      child:
                          Text((this.index == null) ? 'Adicionar ' : 'Editar'),
                      onPressed: () {
                        if (textTitleController.text.isNotEmpty &&
                            textNoteController.text.isNotEmpty) {
                          if (this.index == null) {
                            toDoController.todos.add(
                              ToDo(
                                title: textTitleController.text,
                                note: textNoteController.text,
                              ),
                            );
                          } else {
                            var editing = toDoController.todos[index!];
                            editing.title = textTitleController.text;
                            toDoController.todos[index!] = editing;
                          }
                          Get.back();
                        } else if (textTitleController.text.isEmpty ||
                            textNoteController.text.isEmpty) {
                          Get.snackbar('Erro', 'Todos campos são necessarios !',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                              colorText: pinkClr,
                              icon: Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red,
                              ),
                              duration: Duration(seconds: 1));
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
