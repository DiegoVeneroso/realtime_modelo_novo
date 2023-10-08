import 'package:get/get.dart';
import 'package:realtime_modelo/app/repositories/home_repositories.dart';

import 'home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(repository: HomeRepository()),
    );
  }
}
