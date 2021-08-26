import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../client_injector.dart';
import '../../home.dart';
import '../widgets/task_card_widget.dart';
import '../widgets/task_form_dialog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  static Widget create(BuildContext context) {
    return Provider<HomeBloc>(
        create: (context) => ClientInjector.resolve<HomeBloc>(),
        dispose: (_, bloc) => bloc.onDispose(),
        child: HomeScreen());
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc get bloc => Provider.of<HomeBloc>(context, listen: false);

  Future<void> _onCreateOrEditTaskPressed(TaskModel task) async {
    final taskModel = await showDialog<TaskModel>(
        context: context,
        builder: (context) => TaskFormDialogWidget(
              model: task,
            ));

    if (taskModel == null) {
      return;
    }

    if (taskModel.id == null) {
      bloc.dispatchEvent(CreateTask(taskModel));
    } else {
      bloc.dispatchEvent(UpdateTask(taskModel));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingAddButton(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Lista de tarefas'),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<HomeState>(
        stream: bloc.state,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final state = snapshot.data;
            if (state is Stable) {
              return _buildTasks(context);
            } else if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            }
          }
          return Container();
        });
  }

  Widget _buildTasks(BuildContext context) {
    return StreamBuilder<List<TaskModel>>(
        stream: bloc.taskStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildTaskList(snapshot.data, context);
          } else if (snapshot.hasError) {
            return Center(child: Text('Algo de errado aconteceu!'));
          }
          return Container();
        });
  }

  Widget _buildTaskList(List<TaskModel> tasks, BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskCardWidget(
            taskModel: tasks[index],
            onTap: () => _onCreateOrEditTaskPressed(tasks[index]),
            onDismiss: () => bloc.dispatchEvent(DeleteTask(tasks[index].id)),
            onTogglePressed: (value) =>
                bloc.dispatchEvent(ToggleDoneTask(tasks[index])),
          );
        });
  }

  Widget _buildFloatingAddButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onCreateOrEditTaskPressed(null));
  }
}
