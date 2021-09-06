import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controllers/to_do.controller.dart';
import 'package:mobile/models/to_do.model.dart';

class TodoAddBottomSheet extends StatelessWidget {
  final controller = Get.find<TodoController>();

  final bool keyboardIsOpen;

  TodoAddBottomSheet({@required this.keyboardIsOpen});

  void _onSubmit(String description) {
    if (description.trim()?.isEmpty ?? true) return;

    if (controller.selectedId == null)
      controller.add(Todo(description: description, sequence: 0));
    else
      controller.edit(controller.selectedId, description);

    controller.inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(bottom: !keyboardIsOpen ? padding.bottom : 0),
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: controller.inputController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Criar nova tarefa',
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  onFieldSubmitted: (String value) {
                    _onSubmit(value);
                  },
                  onChanged: (value) => controller.bottomSheetController?.setState(() {}),
                ),
              ),
              if (controller.selectedId == null)
                IconButton(
                  icon: Icon(
                    Icons.arrow_circle_up_rounded,
                    size: 30,
                    color: (controller.inputController.text?.trim()?.isNotEmpty ?? false)
                        ? Theme.of(context).accentColor
                        : Colors.grey[300],
                  ),
                  onPressed: () {
                    _onSubmit(controller.inputController.text);
                    controller.bottomSheetController?.setState(() {});
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
