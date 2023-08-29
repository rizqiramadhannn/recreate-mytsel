import 'package:get/get.dart';
import 'package:mytsel/app/modules/home/controllers/homeService.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeService>(() => HomeService());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
