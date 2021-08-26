import 'package:mobile/core/core.dart';
import 'package:mobile/features/home/home_di.dart';

List<DependencyContainer> _dependencies = [HomeDI()];
final Injector _injector = InjectorGetIt();

abstract class ClientInjector {
  static void injectAll() {
    _dependencies.forEach((element) => element.registerAll(_injector));
  }

  static T resolve<T>() => _injector.get<T>();
}
