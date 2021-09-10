import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class BaseDao<T> {
  Future<void> save({@required String id, @required T value}) async {
    var table = await Hive.openBox<T>(T.toString());
    await table.put(id, value);
  }

  Future<void> update({@required index, @required T value}) async {
    var table = await Hive.openBox<T>(T.toString());
    await table.putAt(index, value);
  }

  Future<void> updateWhere({@required Function(T value) where, @required T value}) async {
    var table = await Hive.openBox<T>(T.toString());
    var items = table.values.where(where);
    items.forEach((i) async => await table.put(i.toString(), value));
  }

  Future<void> delete({String id, Function(T value) where}) async {
    var table = await Hive.openBox<T>(T.toString());
    if (id != null) {
      await table.delete(id);
    } else if (where != null) {
      var items = table.values.where(where);
      items.forEach((i) async => await table.delete(i.toString()));
    }
  }

  Future<T> selectById(String id) async {
    var table = await Hive.openBox<T>(T.toString());
    var key = table.keys.firstWhere((k) => k == id, orElse: () => null);
    var value = table.get(key ?? '');
    return value;
  }

  Future<List<T>> select(Function(T value) where) async {
    var table = await Hive.openBox<T>(T.toString());
    var items = table.values.where(where).toList();
    return items;
  }

  Future<List<T>> selectAll() async {
    var table = await Hive.openBox<T>(T.toString());
    var values = table.values.toList();
    return values;
  }

  Future<void> clear() async {
    var table = await Hive.openBox<T>(T.toString());
    await table.clear();
  }
}
