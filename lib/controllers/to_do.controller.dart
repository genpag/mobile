import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/models/removed_todo_item.model.dart';
import 'package:mobile/models/to_do.model.dart';
import 'package:sqflite/sqflite.dart';

class TodoController extends GetxController {
  static const _tableName = 'todo';

  final list = RxList<Todo>();
  final isLoading = RxBool(false);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final inputController = TextEditingController();
  final scrollController = ScrollController();

  int selectedId;

  Database db;
  PersistentBottomSheetController bottomSheetController;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarController;

  TodoController() {
    _initController();
  }

  @override
  void onClose() {
    super.onClose();

    db?.close();
  }

  _initController() async {
    isLoading.value = true;

    final databasePath = await getDatabasesPath();
    final path = '$databasePath/todo_list.db';

    db = await openDatabase(path, version: 1, onCreate: (Database _db, int version) async {
      await _db.execute(
          'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, description TEXT, completed INTEGER, sequence INTEGER)');
    });

    list.assignAll((await db.query(_tableName, orderBy: 'sequence')).map((json) => Todo.fromJson(json)));

    isLoading.value = false;
  }

  Future<void> _reorderList() async {
    list.asMap().forEach((i, data) {
      data.sequence = i;
    });

    db.transaction((txn) async {
      for (final data in list) {
        await txn.update(_tableName, {'sequence': data.sequence}, where: 'id = ?', whereArgs: [data.id]);
      }
    });
  }

  Future<bool> add(Todo item, {int indexToAdd = 0, bool scrollToTop = true}) async {
    final id = await db.insert(_tableName, item.toJson());

    // Can't insert
    if (id == null) return false;

    item.id = id;
    list.insert(indexToAdd, item);

    await _reorderList();

    if (scrollToTop && scrollController.hasClients)
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 400),
        curve: Curves.bounceIn,
      );

    return true;
  }

  Future<bool> edit(int id, String description) async {
    final rowsAffected = await db.update(_tableName, {'description': description}, where: 'id = ?', whereArgs: [id]);

    final item = list.singleWhere((data) => data.id == id);

    item.description = description;

    return rowsAffected > 0;
  }

  Future<bool> remove(int id, int index) async {
    final rowsAffected = await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);

    // Can't delete
    if (rowsAffected <= 0) return false;

    list.removeAt(index);

    _reorderList();

    return true;
  }

  void undo(RemovedTodoItem removedItem) async {
    await add(removedItem.item, indexToAdd: removedItem.index, scrollToTop: false);
  }

  Future<bool> onComplete(int id, bool completed) async {
    final rowsAffected =
        await db.update(_tableName, {'completed': completed ? 1 : 0}, where: 'id = ?', whereArgs: [id]);

    final updated = rowsAffected > 0;

    if (updated) {
      final copyList = [...list];
      final index = copyList.indexWhere((item) => item.id == id);
      final item = copyList.removeAt(index);

      // If completed add to the end of list, else, put above completed items
      if (completed) {
        copyList.add(item);
      } else {
        final newIndex = copyList.lastIndexWhere((item) => !item.completed);
        copyList.insert(newIndex + 1, item);
      }

      list.assignAll(copyList);

      await _reorderList();
    }

    return updated;
  }

  void onReorderList(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final copyList = [...list];

    final item = copyList.removeAt(oldIndex);
    copyList.insert(newIndex, item);

    list.assignAll(copyList);

    _reorderList();
  }
}
