import 'package:get/get.dart';

import '../controllers/controller.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
  }
}
