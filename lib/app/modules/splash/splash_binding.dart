import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(GetStorage()));
  }
}
