class DataSourceException {
  final String message;
  DataSourceException({this.message = 'Undefined message'});
}

class CacheException extends DataSourceException {
  CacheException({String message = 'Undefined message'})
      : super(message: message);
}

class RemoteException extends DataSourceException {
  RemoteException({String message = 'Undefined message'})
      : super(message: message);
}
