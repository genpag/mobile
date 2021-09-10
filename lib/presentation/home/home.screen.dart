import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/presentation/home/widgets/header_home.widget.dart';
import './controllers/home.controller.dart';
import 'widgets/lista_tarefas.widget.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: controller.abrirForm,
        child: Icon(
          Icons.add,
          size: 22,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepOrange[200],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 50,
          bottom: 50,
        ),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeaderHomeWidget(),
                const SizedBox(height: 20),
                ListaTarefasWidget(
                  tituloLista: 'Tarefas não realizadas',
                  isExpandido: controller.isNaoRealizadasExpanded.value,
                  onExpanded: controller.changeIsNaoRealizadasExpanded,
                  tasks: controller.tasks
                      .where((e) => !e.isRealizado.value)
                      .toList(),
                ),
                const SizedBox(height: 20),
                ListaTarefasWidget(
                  tituloLista: 'Tarefas realizadas',
                  isExpandido: controller.isRealizadasExpanded.value,
                  onExpanded: controller.changeisRealizadasExpanded,
                  tasks: controller.tasks
                      .where((e) => e.isRealizado.value)
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
