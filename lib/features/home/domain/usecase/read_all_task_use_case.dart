import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/home/home.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/home_repository.dart';

class ReadAllTaskUseCase
    implements UseCase<ReadAllTaskUseCaseParams, List<TaskModel>> {
  final HomeRepository repository;

  ReadAllTaskUseCase({@required this.repository});

  @override
  Future<Either<Failure, List<TaskModel>>> call(
      {ReadAllTaskUseCaseParams params}) {
    return repository.readAllTask(index: params.index, ammount: params.ammount);
  }
}

class ReadAllTaskUseCaseParams {
  final int index;
  final int ammount;

  ReadAllTaskUseCaseParams({@required this.index, @required this.ammount});
}
