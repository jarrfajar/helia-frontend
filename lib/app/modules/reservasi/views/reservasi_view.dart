import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/reusable/button.dart';
import 'package:helia/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../controllers/reservasi_controller.dart';

class ReservasiView extends GetView<ReservasiController> {
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: ColorSelect.black,
        ),
        title: const Text(
          'Name of Resevation',
          style: TextStyle(
            color: ColorSelect.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // NAME
            TextFormField(
              controller: controller.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                suffixIcon: GestureDetector(
                  child: const Icon(
                    Icons.person,
                    size: 24.0,
                  ),
                ),
                contentPadding: const EdgeInsets.all(20.0),
                filled: true,
                fillColor: ColorSelect.greySoft,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.7,
                    color: ColorSelect.green,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: "Name",
              ),
            ),
            const SizedBox(height: 20.0),

            // BIRDTHDAY
            TextFormField(
              readOnly: true,
              keyboardType: TextInputType.datetime,
              controller: controller.birthday,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  controller.birthday.text = formattedDate;
                }
                // } else {
                //   print("Date is not selected");
                // }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                suffixIcon: GestureDetector(
                  child: const Icon(
                    Icons.calendar_month,
                    size: 24.0,
                  ),
                ),
                contentPadding: const EdgeInsets.all(20.0),
                filled: true,
                fillColor: ColorSelect.greySoft,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.7,
                    color: ColorSelect.green,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: "Birthday",
              ),
            ),
            const SizedBox(height: 20.0),

            // EMAIL
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: controller.email,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                suffixIcon: GestureDetector(
                  // onTap: () => controller.isHidden.toggle(),
                  child: const Icon(
                    Icons.email,
                    size: 24.0,
                  ),
                ),
                contentPadding: const EdgeInsets.all(20.0),
                filled: true,
                fillColor: ColorSelect.greySoft,
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
            const SizedBox(height: 20.0),

            // PHONE
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: controller.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                suffixIcon: GestureDetector(
                  child: const Icon(
                    Icons.phone_android,
                    size: 24.0,
                  ),
                ),
                contentPadding: const EdgeInsets.all(20.0),
                filled: true,
                fillColor: ColorSelect.greySoft,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.7,
                    color: ColorSelect.green,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: "Phone",
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),

      // BUTTON
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RsButton(
          onPress: () {
            if (controller.name.text != '' &&
                controller.birthday.text != '' &&
                controller.email.text != '' &&
                controller.phone.text != '') {
              Get.toNamed(
                Routes.CONFIRM_RESERVASI,
                arguments: [
                  data,
                  [
                    controller.name.text,
                    controller.birthday.text,
                    controller.email.text,
                    controller.phone.text,
                  ]
                ],
              );
            } else {
              controller.toast(message: "Name, birthday, email and phone is required", color: Colors.red);
            }
          },
          color: ColorSelect.green,
          isLoading: controller.isLoading.isTrue,
          label: 'Continue',
        ),
      ),
    );
  }
}
