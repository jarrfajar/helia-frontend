import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helia/app/routes/app_pages.dart';

class ReservasiController extends GetxController {
  late TextEditingController name, email, birthday, phone;

  RxBool isLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    email = TextEditingController();
    birthday = TextEditingController();
    phone = TextEditingController();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    birthday.dispose();
    phone.dispose();
    super.onClose();
  }

  // TOATS
  void toast({required String message, required Color color}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void test() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.all(30.0),
              decoration: const BoxDecoration(
                color: Color(0xff7210FF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.check_box_rounded,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Center(
              child: Text(
                "Booking Succesfull!",
                style: TextStyle(
                  color: Color(0xff7210FF),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Center(
              child: Text(
                "You have successfully made payment and book the services.",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7210FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {},
                child: const Text("View E-Receipt"),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xfff1e7ff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () => Get.offAllNamed(Routes.HOME),
                child: const Text(
                  "Back to home",
                  style: TextStyle(
                    color: Color(0xff7210FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
