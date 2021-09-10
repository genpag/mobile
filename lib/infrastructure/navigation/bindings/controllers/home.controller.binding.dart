import 'package:get/get.dart';
import 'package:mobile/infrastructure/navigation/bindings/domains/todo_domain.binding.dart';
import 'package:mobile/presentation/home/controllers/home.controller.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    var toToDomainBinding = TodoDomainBinding();
    Get.lazyPut<HomeController>(
      () => HomeController(
        toDoDomainService: toToDomainBinding.getDomainService(),
      ),
    );
  }
}
