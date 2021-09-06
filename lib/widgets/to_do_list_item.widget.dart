import 'package:flutter/material.dart';
import 'package:mobile/models/to_do.model.dart';
import 'package:mobile/widgets/rounded_checkbox.widget.dart';

class TodoListItem extends StatefulWidget {
  final Todo item;
  final Function(bool) onComplete;
  final Function(DismissDirection) onDismissed;
  final Function onEdit;

  TodoListItem({
    @required this.item,
    @required this.onComplete,
    @required this.onDismissed,
    @required this.onEdit,
  }) : super(key: ValueKey<Todo>(item));

  @override
  State<StatefulWidget> createState() => _TodoListItemState(completed: item.completed);
}

class _TodoListItemState extends State<TodoListItem> {
  bool completed;

  _TodoListItemState({@required this.completed});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(
          const Radius.circular(
            5,
          ),
        ),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: widget.onEdit,
        child: Dismissible(
          key: ValueKey<Todo>(widget.item),
          onDismissed: widget.onDismissed,
          direction: DismissDirection.endToStart,
          background: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'Remover',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.item.description,
                    style: TextStyle(
                      decoration: completed ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: RoundedCheckbox(
                    value: completed,
                    onChanged: (value) {
                      setState(() {
                        completed = value;
                      });
                      widget.onComplete(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
