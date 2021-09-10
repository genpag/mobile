import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/presentation/home/controllers/home.controller.dart';

class HeaderHomeWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final dataAtual = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat.yMMMMd('pt_BR').format(dataAtual),
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Text(
            '''${controller.todosList.where((e) => !e.isRealizado.value).length} pendentes, ${controller.todosList.where((e) => e.isRealizado.value).length} realizadas''',
            style: TextStyle(
              color: Colors.black26,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Divider(),
      ],
    );
  }
}
