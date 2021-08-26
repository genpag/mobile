import 'dart:async';

import 'package:meta/meta.dart';
import 'package:mobile/core/arch/base_bloc.dart';
import 'package:mobile/core/failures/failure.dart';
import 'package:mobile/features/home/home.dart';

import '../../domain/domain.dart';
import 'home_state.dart';

class HomeBloc implements BaseBloc {
  final CreateTaskUseCase createTaskUseCase;
  final ReadAllTaskUseCase readAllTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  HomeBloc(
      {@required this.createTaskUseCase,
      @required this.readAllTaskUseCase,
      @required this.updateTaskUseCase,
      @required this.deleteTaskUseCase}) {
    initialize();
  }

  StreamController<HomeEvent> _eventController = StreamController();

  StreamController<HomeState> _stateController = StreamController();
  Stream get state => _stateController.stream;

  StreamController<List<TaskModel>> _tasksController = StreamController();
  Stream get taskStream => _tasksController.stream;
  List<TaskModel> _cachedTasks = <TaskModel>[];

  void initialize() {
    _eventController.stream.listen(_onEvent);
    dispatchEvent(ReadAllTask());
  }

  @override
  void onDispose() {
    _eventController.close();
    _tasksController.close();
    _stateController.close();
  }

  void dispatchEvent(HomeEvent event) {
    _eventController.add(event);
  }

  void _dispatchState(HomeState state) {
    _stateController.add(state);
  }

  void _onEvent(HomeEvent event) {
    if (event is CreateTask) {
      _handleCreateTask(event);
    } else if (event is ReadAllTask) {
      _handleReadAllTask(event);
    } else if (event is UpdateTask) {
      _handleUpdateTask(event);
    } else if (event is DeleteTask) {
      _handleDeleteTask(event);
    } else if (event is ToggleDoneTask) {
      _handleToggleDoneTask(event);
    }
  }

  void _handleCreateTask(CreateTask event) async {
    final result = await createTaskUseCase(
        params: CreateTaskUseCaseParams(task: event.taskModel));
    result.fold(
      _handleFailure,
      (id) => _handleSucessCreatedTask(id, event.taskModel),
    );
  }

  void _handleSucessCreatedTask(String id, TaskModel task) {
    task.id = id;
    _cachedTasks.add(task);
    _tasksController.add(_cachedTasks);
  }

  void _handleReadAllTask(ReadAllTask event) async {
    _dispatchState(Loading());

    final result = await readAllTaskUseCase(
        params: ReadAllTaskUseCaseParams(index: 0, ammount: 0));
    result.fold(_handleFailure, _handleSuccessReadAllTask);

    _dispatchState(Stable());
  }

  void _handleSuccessReadAllTask(List<TaskModel> tasks) {
    _cachedTasks.addAll(tasks);
    _tasksController.add(_cachedTasks);
  }

  void _handleUpdateTask(UpdateTask event) async {
    final result = await updateTaskUseCase(
        params: UpdateTaskUseCaseParams(
      taskId: event.taskModel.id,
      taskModel: event.taskModel,
    ));

    result.fold(
        _handleFailure, (r) => _handleSucessUpdateTask(event.taskModel));
  }

  void _handleSucessUpdateTask(TaskModel taskModel) {
    final whereIndex =
        _cachedTasks.indexWhere((element) => element.id == taskModel.id);

    _cachedTasks.removeWhere((element) => element.id == taskModel.id);
    _cachedTasks.insert(whereIndex, taskModel);

    _tasksController.add(_cachedTasks);
  }

  void _handleDeleteTask(DeleteTask event) async {
    final result = await deleteTaskUseCase(
        params: DeleteTaskUseCaseParams(taskId: event.taskId));

    result.fold(_handleFailure, (r) {
      _cachedTasks.removeWhere((element) => element.id == event.taskId);
      _tasksController.add(_cachedTasks);
    });
  }

  void _handleToggleDoneTask(ToggleDoneTask event) async {
    event.taskModel.isDone = !event.taskModel.isDone;

    final result = await updateTaskUseCase(
        params: UpdateTaskUseCaseParams(
      taskId: event.taskModel.id,
      taskModel: event.taskModel,
    ));

    result.fold(_handleFailure, (r) {
      _tasksController.add(_cachedTasks);
    });
  }

  void _handleFailure(Failure failure) {
    print('Algo de errado aconteceu! $failure');
  }
}
