import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/domain/todo/models/todo.model.dart';
import 'package:mobile/presentation/home/controllers/home.controller.dart';
import 'package:mobile/presentation/text_field/text_field.widget.dart';
import 'package:mobile/presentation/text_field/text_field_type.enum.dart';

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
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Cadastrar um novo Todo'),
                const SizedBox(height: 20),
                TextFieldWidget(
                  label: 'Descrição',
                  type: TextFieldType.TEXT,
                  value: toDoModel.descricao,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Selecionar data'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => controller.salvarTodo(toDoModel),
                  child: Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate:
            toDoModel.data?.value != null ? toDoModel.data.value : selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      toDoModel.data?.value = picked;
    }
  }
}
