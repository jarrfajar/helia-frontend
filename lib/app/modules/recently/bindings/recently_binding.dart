import 'package:get/get.dart';

import '../controllers/recently_controller.dart';

class RecentlyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentlyController>(
      () => RecentlyController(),
    );
  }
}
