import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/controllers/auth_controller.dart';
import 'package:helia/app/reusable/button.dart';
import 'package:helia/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  // AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login to your account",
              style: TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.bold,
                color: ColorSelect.black,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),

            // EMAIL
            TextFormField(
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: const EdgeInsets.all(20.0),
                filled: true,
                fillColor: ColorSelect.greySoft,
                prefixIcon: const Icon(
                  Icons.email_rounded,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.7,
                    color: ColorSelect.green,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: "Email",
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),

            // PASSWORD
            Obx(
              () => TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: controller.isHidden.value,
                controller: controller.password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () => controller.isHidden.toggle(),
                    child: Obx(
                      () => Icon(
                        controller.isHidden.isFalse ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        size: 24.0,
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20.0),
                  filled: true,
                  fillColor: ColorSelect.greySoft,
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.7,
                      color: ColorSelect.green,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: "Password",
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),

            // BUTTON
            Obx(
              () => RsButton(
                onPress: () => controller.login(
                  email: controller.email.text,
                  password: controller.password.text,
                ),
                // onPress: () => print([controller.email.text, controller.password.text]),
                color: ColorSelect.green,
                isLoading: controller.isLoading.value,
                label: 'Login',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),

            // TEXT REGISTER
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Not a member? ",
                      style: TextStyle(
                        color: ColorSelect.grey,
                      ),
                    ),
                    TextSpan(
                      text: "Register now",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorSelect.green,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(Routes.REGISTER),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
