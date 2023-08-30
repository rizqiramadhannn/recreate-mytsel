import 'package:get/get.dart';

import '../controllers/loginService.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginService>(() => LoginService());
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
