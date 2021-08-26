import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/home_repository.dart';

class DeleteTaskUseCase implements UseCase<DeleteTaskUseCaseParams, void> {
  final HomeRepository repository;

  DeleteTaskUseCase({@required this.repository});

  @override
  Future<Either<Failure, void>> call({DeleteTaskUseCaseParams params}) {
    return repository.deleteTask(params.taskId);
  }
}

class DeleteTaskUseCaseParams {
  final String taskId;

  DeleteTaskUseCaseParams({@required this.taskId});
}
