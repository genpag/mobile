import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/presentation/home/controllers/home.controller.dart';

import 'button_main.widget.dart';

class DialogConfirmarExclusaoWidget extends GetView<HomeController> {
  final Function onConfirmar;

  DialogConfirmarExclusaoWidget({@required this.onConfirmar});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: 300,
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
                  const SizedBox(height: 20),
                  Icon(
                    Icons.cancel_outlined,
                    size: 60,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Deseja realmente excluir?',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Você quer excluir esse registro? Este processo não poderá ser desfeito.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ButtonMainWidget(
                    onPressed: () => onConfirmar(),
                    texto: 'Excluir',
                    colorBackground: Colors.red,
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
