import 'package:meta/meta.dart';

import '../entities/task_entity.dart';

abstract class HomeDataSource {
  /// Throws an [DataSourceException] if task can't be created
  Future<String> createTask(TaskEntity task);

  Future<List<TaskEntity>> readAllTask(
      {@required int index, @required int ammount});

  /// Throws an [DataSourceException] if task isn't
  /// exist.
  Future<void> updateTask({@required String id, @required TaskEntity task});

  /// Throws an [DataSourceException] if task isn't
  /// exist.
  Future<void> deleteTask(String id);
}
