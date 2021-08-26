import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/failures/failure.dart';
import '../models/task_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, String>> createTask(TaskModel task);
  Future<Either<Failure, List<TaskModel>>> readAllTask(
      {@required int index, @required int ammount});
  Future<Either<Failure, void>> updateTask(
      {@required String id, @required TaskModel task});
  Future<Either<Failure, void>> deleteTask(String id);
}
