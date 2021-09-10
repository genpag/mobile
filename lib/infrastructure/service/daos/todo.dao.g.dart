// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoDaoAdapter extends TypeAdapter<TodoDao> {
  @override
  final int typeId = 1;

  @override
  TodoDao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoDao()
      ..id = fields[0] as String
      ..ordem = fields[1] as int
      ..isRealizado = fields[2] as bool
      ..descricao = fields[3] as String
      ..data = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, TodoDao obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ordem)
      ..writeByte(2)
      ..write(obj.isRealizado)
      ..writeByte(3)
      ..write(obj.descricao)
      ..writeByte(4)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoDaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
