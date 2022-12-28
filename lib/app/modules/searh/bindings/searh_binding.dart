import 'package:get/get.dart';

import '../controllers/searh_controller.dart';

class SearhBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearhController>(
      () => SearhController(),
    );
  }
}
