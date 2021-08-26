import 'package:flutter/material.dart';
import 'package:mobile/features/home/home.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel taskModel;

  final Function() onTap;
  final Function(bool) onTogglePressed;
  final Function() onDismiss;

  const TaskCardWidget(
      {@required this.taskModel,
      @required this.onTap,
      @required this.onTogglePressed,
      @required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        child: ListTile(
          title: Text(taskModel.title),
          subtitle: Text(taskModel.description),
          trailing: Checkbox(
            value: taskModel.isDone ?? false,
            onChanged: onTogglePressed,
          ),
          onTap: onTap,
          isThreeLine: true,
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            onDismiss();
          }
        },
        background: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
        ));
  }
}
