import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/currency_format.dart';
import 'package:helia/app/models/roomsdetail.dart';
import 'package:helia/app/reusable/button.dart';
import 'package:helia/app/reusable/card.dart';
import 'package:helia/app/routes/app_pages.dart';

import '../controllers/confirm_reservasi_controller.dart';

class ConfirmReservasiView extends GetView<ConfirmReservasiController> {
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // [[2022-12-19 00:00:00.000, 2022-12-29 00:00:00.000, 10, [4, 500000]], [fajar, 2022-12-19, fajarjie39@gmail.com, 08524255899]]
    var starDate = data[0][0];
    var endDate = data[0][1];
    var night = data[0][2];
    var id = data[0][3][0];
    var price = data[0][3][1];
    var name = data[1][0];
    var birthday = data[1][1];
    var email = data[1][2];
    var phone = data[1][3];
    var tax = int.parse(data[0][3][1]) * data[0][2] * 10 / 100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: ColorSelect.black,
        ),
        title: const Text(
          'Confirm Reservasi',
          style: TextStyle(
            color: ColorSelect.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FutureBuilder(
              future: controller.getRoomDetail(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                RoomsDetail room = controller.room.first;

                return RsCard(
                  name: "Kamar ${room.title!}",
                  image: '${Api.domainUrl}/storage/room/883kKnzqaODkXimkiNuVwQMhKOT7nzXEU3Lch2YJ.jpg',
                  review: room.reviews!.length.toString(),
                  price: CurrencyFormat.convertToIdr(int.parse(room.category!.price!), 0),
                  category: room.category!.title!,
                  icon: const Icon(
                    Icons.bookmark_border_outlined,
                    size: 32.0,
                  ),
                );
              }),
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.all(20.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Reservation",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: ColorSelect.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Phone",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: ColorSelect.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Chek in",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      // "Desc 14, 2002",
                      controller.dateformat(starDate),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: ColorSelect.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Chek out",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      controller.dateformat(endDate),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: ColorSelect.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.all(20.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${night} Nights",
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(int.parse(price) * night, 0),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: ColorSelect.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Taxes & Fees (10%)",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(tax.toInt(), 0),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: ColorSelect.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                const Divider(),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(int.parse(price) * night + tax.toInt(), 0),
                      // 'sss',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: ColorSelect.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
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
            Get.dialog(
              AlertDialog(
                content: ListView(
                  shrinkWrap: true,
                  children: const [
                    Text("Are you sure this book this room"),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSelect.greenSoft,
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: ColorSelect.green,
                      ),
                    ),
                  ),
                  Obx(
                    () => ElevatedButton(
                      onPressed: () => controller.booking(
                        roomId: id,
                        categoryId: 1,
                        phone: phone,
                        checkin: starDate,
                        checkout: endDate,
                        night: night,
                        price: price,
                        tax: tax.toInt().toString(),
                        total: (int.parse(price) * night + tax.toInt()).toString(),
                      ),
                      child: controller.isLoading.isTrue
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Yes"),
                    ),
                  ),
                ],
              ),
            );
          },
          color: ColorSelect.green,
          isLoading: controller.isLoading.isTrue,
          label: 'Continue',
        ),
      ),
    );
  }
}
