import 'dao.interface.dart';

abstract class Model<T> {
  BaseDao toDao() {
    return null;
  }

  T fromDao(BaseDao b);

  T fromData(Map data) {
    return null;
  }
}
