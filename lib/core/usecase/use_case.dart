import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../failures/failure.dart';

abstract class UseCase<Input, Output> {
  Future<Either<Failure, Output>> call({@required Input params});
}

class NoParams {}
