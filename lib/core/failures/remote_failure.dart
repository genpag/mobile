import 'failure.dart';

class RemoteFailure extends Failure {
  final String message;

  RemoteFailure({this.message = 'Undefined message'});
}
