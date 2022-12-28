import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/controllers/page_index_controller.dart';
import 'package:helia/app/models/booking.dart';
import 'package:helia/app/reusable/NavagationBar.dart';
import 'package:helia/app/reusable/bottomsheet.dart';
import 'package:helia/app/reusable/tabbar.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/my_booking_controller.dart';

class MyBookingView extends GetView<MyBookingController> {
  final PageIndexController pageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyBookingView'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.status.value = 'ongoing',
                    child: RsTabBar(
                      width: Get.width * 0.26,
                      color: controller.status.value == 'ongoing' ? ColorSelect.green : Colors.white,
                      colorText: controller.status.value == 'ongoing' ? Colors.white : ColorSelect.green,
                      label: 'Ongoing',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.status.value = 'completed',
                    child: RsTabBar(
                      width: Get.width * 0.26,
                      color: controller.status.value == 'completed' ? ColorSelect.green : Colors.white,
                      colorText: controller.status.value == 'completed' ? Colors.white : ColorSelect.green,
                      label: 'Completed',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.status.value = 'canceled',
                    child: RsTabBar(
                      width: Get.width * 0.26,
                      color: controller.status.value == 'canceled' ? ColorSelect.green : Colors.white,
                      colorText: controller.status.value == 'canceled' ? Colors.white : ColorSelect.green,
                      label: 'Canceled',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // BODY
              GetBuilder<MyBookingController>(
                builder: (_) => FutureBuilder(
                  future: controller.getBooking(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var data =
                        controller.booking.where((element) => element.status == controller.status.value).toList();
                    return Expanded(
                      child: ListView.builder(
                        // itemCount: controller.booking.length,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          // Booking booking = controller.booking[index];
                          Booking booking = data[index];

                          return Container(
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 209, 209, 209),
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: '${Api.domainUrl}/${booking.room!.image}',
                                      imageBuilder: (context, imageProvider) => Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      placeholder: (context, url) => Shimmer.fromColors(
                                        baseColor: const Color.fromARGB(255, 230, 230, 230),
                                        highlightColor: Colors.white,
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 20.0),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 236, 236, 236),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Kamar ${booking.room!.title}',
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: ColorSelect.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 12.0),
                                        Text(
                                          booking.room!.category!.title.toString(),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: booking.status != 'canceled'
                                                ? const Color.fromARGB(223, 177, 245, 202)
                                                : const Color.fromARGB(255, 252, 174, 169),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Center(
                                            child: Text(
                                              booking.status.toString(),
                                              style: TextStyle(
                                                color:
                                                    booking.status != 'canceled' ? ColorSelect.green : Colors.redAccent,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                const Divider(thickness: 1),
                                const SizedBox(height: 10.0),

                                // ALERT
                                booking.status != 'ongoing'
                                    ? Container(
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: booking.status == 'completed'
                                              ? const Color.fromARGB(223, 177, 245, 202)
                                              : const Color.fromARGB(255, 252, 174, 169),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              booking.status == 'completed'
                                                  ? Icons.check_circle
                                                  : Icons.warning_rounded,
                                              size: 26.0,
                                              color:
                                                  booking.status == 'completed' ? ColorSelect.green : Colors.redAccent,
                                            ),
                                            const SizedBox(width: 10.0),
                                            Text(
                                              booking.status == 'completed'
                                                  ? "Yeay, you have completed it"
                                                  : "You canceled this room booking",
                                              style: TextStyle(
                                                color: booking.status == 'completed'
                                                    ? ColorSelect.green
                                                    : Colors.redAccent,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: ColorSelect.green,
                                                side: const BorderSide(width: 2, color: ColorSelect.green),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                              ),
                                              onPressed: () => Get.bottomSheet(
                                                RsBottomSheet(
                                                  height: Get.height * 0.3,
                                                  title: 'Cancel Booking',
                                                  contentTitle: const Text(
                                                    "Are you sure want to cancel your room booking?",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: ColorSelect.black,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  contentSubTitle: const SizedBox(height: 20.0),
                                                  cancel: 'Cancel',
                                                  yes: 'Yes, continue',
                                                  isLoading: controller.isLoading.isTrue,
                                                  onPressCancel: () => Get.back(),
                                                  onPressYes: () => controller.cancel(id: booking.id!),
                                                ),
                                              ),
                                              child: const Text("Cancel Booking"),
                                            ),
                                          ),
                                          const SizedBox(width: 12.0),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Text("View Ticket"),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // BOTTOM NAVIGASI
      bottomNavigationBar: NavagationBar(
        controller: pageController.index.value,
        onChanged: (i) => pageController.changePage(i),
      ),
    );
  }
}
