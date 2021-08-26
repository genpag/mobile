import 'package:get_it/get_it.dart';

abstract class Injector {
  void registerSingleton<T extends Object>(T type);
  void registerFactory<T extends Object>(T Function() creator);
  T get<T extends Object>();
}

class InjectorGetIt implements Injector {
  final GetIt _getIt = GetIt.instance;

  @override
  void registerFactory<T extends Object>(T Function() creator) {
    return _getIt.registerFactory<T>(creator);
  }

  @override
  void registerSingleton<T extends Object>(T type) {
    return _getIt.registerSingleton(type);
  }

  @override
  T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
