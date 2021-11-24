import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controllers/to_do_controller.dart';
import 'package:mobile/screens/home_page/widgets/custom_appbar.dart';
import 'package:mobile/screens/home_page/widgets/task_tile.dart';
import 'package:mobile/screens/to_do_page/to_do_page.dart';
import 'package:mobile/utils/themes.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ToDoController toDoController = Get.put(ToDoController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ToDoPage());
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          CustomAppbar(),
          Container(
            width: Get.width,
            height: Get.height * 0.85,
            child: Obx(
              () => ListView.separated(
                itemBuilder: (_, indexList) {
                  return Dismissible(
                    key: UniqueKey(),
                    child: TaskTile(indexList),
                    onDismissed: (_) {
                      var removed = toDoController.todos[indexList];
                      toDoController.todos.removeAt(indexList);
                      Get.snackbar(
                        'Tarefa removida',
                        'A tarefa "${removed.title}" foi removida com sucesso',
                        colorText: Colors.black,
                        backgroundColor: Get.isDarkMode
                            ? Colors.grey[600]
                            : Colors.grey[300],
                        mainButton: TextButton(
                          onPressed: () {
                            toDoController.todos.insert(indexList, removed);
                          },
                          child: Text(
                            'Desfazer',
                            style: titleStyle,
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (_, __) => Divider(),
                itemCount: toDoController.todos.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
