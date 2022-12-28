import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/models/ticket.dart';
import 'package:helia/app/reusable/button.dart';
import 'package:helia/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../controllers/ticket_controller.dart';

class TicketView extends GetView<TicketController> {
  var id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: ColorSelect.black,
        ),
        title: const Text(
          'QR Code',
          style: TextStyle(
            color: ColorSelect.black,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      body: FutureBuilder(
        future: controller.getTicket(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          Ticket ticket = controller.ticket.first;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: TicketWidget(
              width: double.maxFinite,
              height: 550,
              isCornerRounded: true,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 220.0,
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Kamar ${ticket.room!.title}",
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: ColorSelect.black,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        QrImage(
                          data: "1234567890",
                          version: QrVersions.auto,
                          size: 180.0,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: List.generate(
                      150 ~/ 2,
                      (index) => Expanded(
                        child: Container(
                          color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 220.0,
                    // color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Name",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 134, 133, 133),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      ticket.user!.name!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                        color: ColorSelect.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Phone Number",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 134, 133, 133),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      ticket.phone!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                        color: ColorSelect.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),

                        //
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Check in",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 134, 133, 133),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      controller.dateformat(ticket.checkin),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                        color: ColorSelect.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Check out",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 134, 133, 133),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      controller.dateformat(ticket.checkout),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                        color: ColorSelect.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),

                        //
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Check in",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 134, 133, 133),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Kamar 1B",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                        color: ColorSelect.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Check out",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 134, 133, 133),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "123456789012",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                        color: ColorSelect.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Show this ticket to the cashier when you want go to the room",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // BUTTON
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RsButton(
          onPress: () => Get.toNamed(Routes.HOME),
          color: ColorSelect.green,
          isLoading: controller.isLoading.isTrue,
          label: 'Back to Home',
        ),
      ),
    );
  }
}
