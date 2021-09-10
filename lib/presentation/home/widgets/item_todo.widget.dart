import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'check_box_custom.widget.dart';

class ItemTodoWidget extends StatelessWidget {
  final String descricaoTask, dataTask;
  final bool isRealizada;

  const ItemTodoWidget({
    @required this.descricaoTask,
    @required this.dataTask,
    @required this.isRealizada,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.3),
        border: Border.all(width: 1.5, color: Colors.black12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CheckboxWidget(
              selected: RxBool(isRealizada),
              onChanged: () {},
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  descricaoTask,
                  style: TextStyle(
                    decoration: isRealizada ? TextDecoration.lineThrough : null,
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
                      dataTask,
                      style: TextStyle(
                        fontSize: 12,
                        decoration:
                            isRealizada ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
