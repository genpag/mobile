import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../entities/task_entity.dart';
import 'home_data_source.dart';

class HomeLocalDataSourceImpl implements HomeDataSource {
  final _key = 'tasks';

  @override
  Future<String> createTask(TaskEntity task) async {
    return await Hive.openBox(_key).then((value) async {
      final id = Uuid().v1();

      task.id = id;
      await value.put(task.id, task.toJson());

      return id;
    });
  }

  @override
  Future<void> deleteTask(String id) async {
    return await Hive.openBox(_key).then((box) {
      return box.delete(id);
    });
  }

  @override
  Future<List<TaskEntity>> readAllTask(
      {@required int index, @required int ammount}) async {
    return await Hive.openBox(_key).then((value) {
      final list = value.values.map((e) => TaskEntity.fromJson(e)).toList();

      list.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      return list;
    });
  }

  @override
  Future<void> updateTask(
      {@required String id, @required TaskEntity task}) async {
    return await Hive.openBox(_key).then((box) async {
      if (!box.containsKey(id)) {
        return box.put(id, task.toJson());
      }
      await box.delete(id);
      return box.put(id, task.toJson());
    });
  }
}
