import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class BaseDao<T> {
  Future<void> save({@required id, @required T value}) async {
    var table = await Hive.openBox<T>(T.toString());
    await table.put(id, value);
  }

  Future<void> updateWhere({
    @required Function(T value) where,
    @required T value,
  }) async {
    var table = await Hive.openBox<T>(T.toString());
    var values = table.values.toList();
    var item = (values).firstWhere(where);
    await table.putAt(values.indexOf(item), value);
  }

  Future<void> delete({
    String id,
    Function(T value) where,
  }) async {
    var table = await Hive.openBox<T>(T.toString());
    if (id != null) {
      await table.delete(id);
    } else if (where != null) {
      var values = table.values.toList();
      var items = values.where(where);
      items.forEach((i) async => await table.deleteAt(values.indexOf(i)));
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
