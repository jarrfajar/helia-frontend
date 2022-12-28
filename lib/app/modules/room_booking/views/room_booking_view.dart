import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/currency_format.dart';
import 'package:helia/app/reusable/button.dart';
import 'package:helia/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/room_booking_controller.dart';

class RoomBookingView extends GetView<RoomBookingController> {
  var price = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: ColorSelect.black,
        ),
        title: const Text(
          'Select Date',
          style: TextStyle(
            color: ColorSelect.black,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: ColorSelect.greenSoft,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              selectionColor: ColorSelect.green,
              todayHighlightColor: ColorSelect.green,
              rangeSelectionColor: const Color.fromARGB(71, 15, 158, 75),
              showNavigationArrow: true,
              headerStyle: const DateRangePickerHeaderStyle(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onSelectionChanged: (args) {
                controller.startDate.value = controller.dateformat(args.value.startDate.toString());
                controller.rxStartDate.value = args.value.startDate.toString();
                if (args.value.endDate != null) {
                  controller.endDate.value = controller.dateformat(args.value.endDate.toString());
                  controller.rxEndDate.value = args.value.endDate.toString();
                  // COUNT DATE
                  controller.countDate.value =
                      controller.countBeetweenDate(args.value.startDate.toString(), args.value.endDate.toString());
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50.0,
            child: Row(
              children: const [
                Expanded(
                  child: SizedBox(
                    width: 80.0,
                    child: Text(
                      "Check in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: ColorSelect.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40.0),
                Expanded(
                  child: SizedBox(
                    width: 80.0,
                    child: Text(
                      "Check out",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: ColorSelect.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // DATE
          SizedBox(
            height: 60.0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: 100.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(174, 233, 233, 233),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            controller.startDate.value,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.calendar_month,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                  size: 40.0,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: 100.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(174, 233, 233, 233),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            controller.endDate.value,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.calendar_month,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: Obx(
              () => Text(
                "Total: ${CurrencyFormat.convertToIdr(controller.countPrice(int.parse(price[1]), controller.countDate.value), 0)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: ColorSelect.black,
                ),
              ),
            ),
          ),
        ],
      ),

      // BUTTON
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RsButton(
          onPress: () {
            if (controller.rxStartDate.isNotEmpty &&
                controller.rxEndDate.isNotEmpty &&
                controller.countDate.value != 0) {
              Get.toNamed(Routes.RESERVASI, arguments: [
                controller.rxStartDate.value,
                controller.rxEndDate.value,
                controller.countDate.value,
                price,
              ]);
            } else {
              controller.toast(message: "Select date", color: Colors.red);
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
