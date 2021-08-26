import 'package:mobile/features/home/home.dart';

abstract class HomeEvent {}

class ToggleDoneTask extends HomeEvent {
  TaskModel taskModel;
  ToggleDoneTask(this.taskModel);
}

class CreateTask extends HomeEvent {
  TaskModel taskModel;
  CreateTask(this.taskModel);
}

class ReadAllTask extends HomeEvent {}

class UpdateTask extends HomeEvent {
  TaskModel taskModel;
  UpdateTask(this.taskModel);
}

class DeleteTask extends HomeEvent {
  String taskId;
  DeleteTask(this.taskId);
}
