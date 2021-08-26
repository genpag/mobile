import 'package:mobile/core/core.dart';
import 'package:mobile/features/home/home.dart';

class HomeDI implements DependencyContainer {
  void registerAll(Injector container) {
    // Register of datasources
    container.registerSingleton<HomeDataSource>(HomeLocalDataSourceImpl());

    //Register of repositories
    container.registerSingleton<HomeRepository>(HomeRepositoryImpl(
      localDataSource: container.get(),
    ));

    //Register of usecases
    container.registerSingleton(
      CreateTaskUseCase(repository: container.get()),
    );
    container.registerSingleton(
      ReadAllTaskUseCase(repository: container.get()),
    );
    container.registerSingleton(
      UpdateTaskUseCase(repository: container.get()),
    );
    container.registerSingleton(
      DeleteTaskUseCase(repository: container.get()),
    );

    // Register of blocs
    container.registerFactory(() => HomeBloc(
        createTaskUseCase: container.get(),
        readAllTaskUseCase: container.get(),
        updateTaskUseCase: container.get(),
        deleteTaskUseCase: container.get()));
  }
}
