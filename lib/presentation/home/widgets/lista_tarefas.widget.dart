import 'package:flutter/material.dart';
import 'package:mobile/domain/todo/models/todo.model.dart';

import 'item_todo.widget.dart';

class ListaTarefasWidget extends StatelessWidget {
  final String tituloLista;
  final bool isExpandido;
  final Function onExpanded;
  final List<TodoModel> tasks;

  const ListaTarefasWidget({
    @required this.tituloLista,
    @required this.isExpandido,
    @required this.onExpanded,
    @required this.tasks,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => onExpanded(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tituloLista,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                isExpandido
                    ? Icons.expand_less_outlined
                    : Icons.expand_more_outlined,
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        Visibility(
          visible: !isExpandido,
          child: Container(
            constraints: BoxConstraints(maxHeight: 320, minHeight: 10),
            child: ReorderableListView(
              onReorder: (i, x) {},
              buildDefaultDragHandles: false,
              shrinkWrap: true,
              children: [
                for (int i = 0; i < tasks.length; i++)
                  Padding(
                    key: ValueKey(i),
                    padding: const EdgeInsets.all(8.0),
                    child: ReorderableDelayedDragStartListener(
                      index: i,
                      child: ItemTodoWidget(
                        descricaoTask: tasks[i].descricao.value,
                        dataTask: tasks[i].data.toString(),
                        isRealizada: tasks[i].isRealizado.value,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
