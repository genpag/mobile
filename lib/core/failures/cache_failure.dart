import 'failure.dart';

class CacheFailure extends Failure {
  final String message;

  CacheFailure({this.message = 'Undefined message'});
}
