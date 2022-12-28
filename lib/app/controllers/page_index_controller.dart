import 'package:get/get.dart';
import 'package:helia/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt index = 0.obs;

  void changePage(int i) async {
    index.value = i;
    switch (i) {
      case 1:
        Get.offAllNamed(Routes.SEARH);
        break;
      case 2:
        Get.offAllNamed(Routes.MY_BOOKING);
        break;
      case 3:
        print(index.value);
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }
}
