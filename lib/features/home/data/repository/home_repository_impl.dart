import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/home/home.dart';
import '../../domain/domain.dart';

import '../../../../core/core.dart';
import '../datasource/home_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource localDataSource;

  HomeRepositoryImpl({@required this.localDataSource});

  @override
  Future<Either<Failure, String>> createTask(TaskModel task) async {
    try {
      final result = await localDataSource.createTask(task.toEntity());
      return Right(result);
    } on CacheException catch (ex) {
      return Left(CacheFailure(message: ex.message));
    } on RemoteException catch (ex) {
      return Left(RemoteFailure(message: ex.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      final result = await localDataSource.deleteTask(id);
      return Right(result);
    } on CacheException catch (ex) {
      return Left(CacheFailure(message: ex.message));
    } on RemoteException catch (ex) {
      return Left(RemoteFailure(message: ex.message));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> readAllTask(
      {int index, int ammount}) async {
    try {
      final result =
          await localDataSource.readAllTask(index: index, ammount: ammount);
      return Right(result);
    } on CacheException catch (ex) {
      return Left(CacheFailure(message: ex.message));
    } on RemoteException catch (ex) {
      return Left(RemoteFailure(message: ex.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(
      {@required String id, @required TaskModel task}) async {
    try {
      final result =
          await localDataSource.updateTask(id: id, task: task.toEntity());
      return Right(result);
    } on CacheException catch (ex) {
      return Left(CacheFailure(message: ex.message));
    } on RemoteException catch (ex) {
      return Left(RemoteFailure(message: ex.message));
    }
  }
}
