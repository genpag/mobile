import 'package:get/get.dart';
import 'package:mobile/presentation/home/home.screen.dart';
import 'bindings/controllers/home.controller.binding.dart';
import 'routes.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeControllerBinding(),
    ),
  ];
}
