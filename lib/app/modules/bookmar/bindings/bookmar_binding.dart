import 'package:get/get.dart';

import '../controllers/bookmar_controller.dart';

class BookmarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarController>(
      () => BookmarController(),
    );
  }
}
