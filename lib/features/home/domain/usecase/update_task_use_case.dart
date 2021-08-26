import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/home/domain/models/task_model.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/home_repository.dart';

class UpdateTaskUseCase implements UseCase<UpdateTaskUseCaseParams, void> {
  final HomeRepository repository;

  UpdateTaskUseCase({@required this.repository});

  @override
  Future<Either<Failure, void>> call({UpdateTaskUseCaseParams params}) {
    return repository.updateTask(id: params.taskId, task: params.taskModel);
  }
}

class UpdateTaskUseCaseParams {
  final String taskId;
  final TaskModel taskModel;

  UpdateTaskUseCaseParams({@required this.taskId, @required this.taskModel});
}
