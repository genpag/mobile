import 'package:hive/hive.dart';
import 'package:mobile/domain/core/interfaces/dao.interface.dart';

part 'todo.dao.g.dart';

@HiveType(typeId: 1)
class TodoDao extends BaseDao<TodoDao> {
  @HiveField(0)
  String id;

  @HiveField(1)
  int ordem;

  @HiveField(2)
  bool isRealizado;

  @HiveField(3)
  String descricao;

  @HiveField(4)
  DateTime data;
}
