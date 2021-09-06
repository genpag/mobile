import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controllers/to_do.controller.dart';
import 'package:mobile/models/removed_todo_item.model.dart';
import 'package:mobile/models/to_do.model.dart';
import 'package:mobile/widgets/custom_app_bar.widget.dart';
import 'package:mobile/widgets/empty_list.widget.dart';
import 'package:mobile/widgets/to_do_add_bottom_sheet.widget.dart';
import 'package:mobile/widgets/to_do_list_item.widget.dart';
import 'package:mobile/widgets/to_do_list_item_skeleton.widget.dart';

class TodoListPage extends StatelessWidget {
  final controller = Get.put(TodoController());

  TodoListItem _buildListItem(Todo item, {int index}) {
    return TodoListItem(
      item: item,
      onComplete: (value) {
        item.completed = value;
        controller.onComplete(item.id, value);
      },
      onDismissed: (dismissed) async {
        controller.remove(item.id, index);

        controller.snackBarController = controller.scaffoldKey.currentState.showSnackBar(
          SnackBar(
            shape: const RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(15),
              ),
            ),
            content: const Text('Tarefa excluída com sucesso!'),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () => controller.undo(RemovedTodoItem(item: item, index: index)),
            ),
          ),
        );
      },
      onEdit: () {
        controller.selectedId = item.id;
        controller.inputController.text = item.description;

        if (!Navigator.of(controller.scaffoldKey.currentContext).canPop())
          _showBottomSheet(
            controller.scaffoldKey.currentContext,
            true,
          );
      },
    );
  }

  TodoListItemSkeleton _buildListItemSkeleton(int index) {
    return TodoListItemSkeleton(index: index);
  }

  void _showBottomSheet(BuildContext context, bool keyboardIsOpen) {
    controller.bottomSheetController = controller.scaffoldKey.currentState.showBottomSheet(
      (ctx) {
        return TodoAddBottomSheet(
          keyboardIsOpen: keyboardIsOpen,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    // Check if keyboard is open
    bool _keyboardIsOpen = _mediaQuery.viewInsets.bottom != 0;

    // If keyboard is close and bottom sheet open, close bottom sheet
    if (!_keyboardIsOpen && Navigator.of(context).canPop()) controller.bottomSheetController?.close();

    void _onCreate() {
      _keyboardIsOpen = true;
      controller.selectedId = null;
      controller.inputController.clear();
      _showBottomSheet(context, _keyboardIsOpen);
    }

    return Scaffold(
      key: controller.scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: CustomAppBar(
        title: 'Todo List',
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Obx(
        () {
          return controller.isLoading.value
              ? ListView.builder(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, int index) {
                    return _buildListItemSkeleton(index);
                  },
                )
              : controller.list.length > 0
                  ? ReorderableListView(
                      scrollController: controller.scrollController,
                      padding: EdgeInsets.only(
                        top: 5,
                      ),
                      children: [
                        for (int index = 0; index < controller.list.length; index++)
                          _buildListItem(
                            controller.list[index],
                            index: index,
                          )
                      ],
                      onReorder: controller.onReorderList,
                    )
                  : EmptyList(
                      title: 'Nenhuma Tarefa Encontrada',
                      subTitle: 'Você ainda não criou nenhuma tarefa. Clique no botão abaixo e crie uma nova tarefa.',
                      imagePath: 'assets/images/list.png',
                      canCreate: !_keyboardIsOpen,
                      addButtonTitle: 'Criar nova tarefa',
                      onTap: _onCreate,
                    );
        },
      ),
      floatingActionButton: Visibility(
        visible: !_keyboardIsOpen,
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: _onCreate,
        ),
      ),
    );
  }
}
