import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/domain/todo/models/todo.model.dart';
import 'package:mobile/presentation/home/controllers/home.controller.dart';

import 'check_box_custom.widget.dart';

class ItemTodoWidget extends GetView<HomeController> {
  final TodoModel toDo;

  const ItemTodoWidget({
    @required this.toDo,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.abrirForm(toDo),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.3),
          border: Border.all(width: 1.5, color: Colors.black12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CheckboxWidget(
                    selected: toDo.isRealizado,
                    onChanged: () {
                      toDo.isRealizado.value = !toDo.isRealizado.value;
                      controller.salvarTodo(toDo);
                    },
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        toDo.descricao.value,
                        style: TextStyle(
                          decoration: toDo.isRealizado.value
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            toDo?.data?.value != null
                                ? DateFormat.yMd('pt_BR')
                                    .format(toDo?.data?.value)
                                : '',
                            style: TextStyle(
                              fontSize: 12,
                              decoration: toDo.isRealizado.value
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () => controller.removeTodo(toDo),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
