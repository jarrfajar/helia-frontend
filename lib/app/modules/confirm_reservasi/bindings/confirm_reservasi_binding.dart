import 'package:get/get.dart';

import '../controllers/confirm_reservasi_controller.dart';

class ConfirmReservasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmReservasiController>(
      () => ConfirmReservasiController(),
    );
  }
}
