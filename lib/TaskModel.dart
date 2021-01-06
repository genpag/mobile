class TaskModel {
  int id = 0;
  String descricao = "";

  TaskModel({
    this.id,
    this.descricao
  });

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return TaskModel(id: map.values.first, descricao: map.values.last);
  }

}