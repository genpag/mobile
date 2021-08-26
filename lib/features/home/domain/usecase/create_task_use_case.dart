import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/use_case.dart';
import 'package:meta/meta.dart';

import '../models/task_model.dart';
import '../repository/home_repository.dart';

class CreateTaskUseCase implements UseCase<CreateTaskUseCaseParams, String> {
  final HomeRepository repository;

  CreateTaskUseCase({@required this.repository});

  @override
  Future<Either<Failure, String>> call({CreateTaskUseCaseParams params}) {
    return repository.createTask(params.task);
  }
}

class CreateTaskUseCaseParams {
  final TaskModel task;

  CreateTaskUseCaseParams({@required this.task});
}
