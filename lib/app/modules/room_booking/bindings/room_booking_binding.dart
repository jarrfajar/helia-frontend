import 'package:get/get.dart';

import '../controllers/room_booking_controller.dart';

class RoomBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomBookingController>(
      () => RoomBookingController(),
    );
  }
}
