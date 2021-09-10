import 'package:get/get.dart';
import 'package:mobile/domain/core/interfaces/dao.interface.dart';
import 'package:mobile/domain/core/interfaces/model.interface.dart';
import 'package:mobile/infrastructure/service/daos/todo.dao.dart';

class TodoModel extends Model<TodoModel> {
  final Rx<bool> isRealizado;
  final Rx<int> ordem;
  final RxString descricao;
  final Rx<DateTime> data;

  @override
  // ignore: override_on_non_overriding_member
  bool get isValid {
    final descricaoValid =
        descricao.value != null && descricao.value.isNotEmpty;
    final dataValid = data != null;

    return descricaoValid && dataValid;
  }

  TodoModel({
    this.isRealizado,
    this.ordem,
    this.descricao,
    this.data,
  });

  factory TodoModel.blank(int ordem) {
    return TodoModel(
      isRealizado: Rx(false),
      ordem: Rx(ordem),
      descricao: ''.obs,
      data: Rx<DateTime>(),
    );
  }

  @override
  BaseDao toDao() {
    return TodoDao()
      ..descricao = this.descricao.value
      ..isRealizado = this.isRealizado.value
      ..ordem = this.ordem.value
      ..data = this.data.value;
  }

  @override
  TodoModel fromDao(BaseDao b) {
    TodoDao baseDao = b as TodoDao;
    return TodoModel(
      descricao: baseDao.descricao.obs,
      isRealizado: Rx(baseDao.isRealizado),
      ordem: Rx(baseDao.ordem),
      data: Rx(baseDao.data),
    );
  }
}
