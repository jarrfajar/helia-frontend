import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/controllers/page_index_controller.dart';
import 'package:helia/app/currency_format.dart';
import 'package:helia/app/models/rooms.dart';
import 'package:helia/app/reusable/NavagationBar.dart';
import 'package:helia/app/reusable/card.dart';
import 'package:helia/app/reusable/grid.dart';

import '../controllers/searh_controller.dart';

class SearhView extends GetView<SearhController> {
  final PageIndexController pageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // SEARCH BAR
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) => controller.searching(value),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(10.0),
                        filled: true,
                        fillColor: ColorSelect.greySoft,
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.7,
                            color: ColorSelect.green,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: "Search",
                      ),
                    ),
                  ),

                  // ICON BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Obx(
                          () => Icon(
                            Icons.my_library_books_sharp,
                            size: 30,
                            color: controller.isGrid.isFalse
                                ? ColorSelect.green
                                : const Color.fromARGB(255, 150, 142, 142),
                          ),
                        ),
                        tooltip: 'Open shopping cart',
                        onPressed: () => controller.isGrid.value = false,
                      ),
                      IconButton(
                        icon: Obx(
                          () => Icon(
                            Icons.grid_view_rounded,
                            size: 30,
                            color:
                                controller.isGrid.isTrue ? ColorSelect.green : const Color.fromARGB(255, 150, 142, 142),
                          ),
                        ),
                        tooltip: 'Open shopping cart',
                        onPressed: () => controller.isGrid.value = true,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // BODY
              FutureBuilder(
                future: controller.getRoom(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Expanded(
                    child: Obx(
                      () => controller.isGrid.isFalse
                          ? ListView.builder(
                              itemCount: controller.cari.isEmpty ? controller.room.length : controller.cari.length,
                              itemBuilder: (context, index) {
                                Room room = controller.cari.isEmpty ? controller.room[index] : controller.cari[index];

                                return RsCard(
                                  name: 'Kamar ${room.title!}',
                                  image: '${Api.domainUrl}/${room.image}',
                                  review: room.reviews!.length.toString(),
                                  price: CurrencyFormat.convertToIdr(int.parse(room.category!.price!), 0),
                                  category: room.category!.title!,
                                  icon: GestureDetector(
                                    onTap: () => print('bookmar'),
                                    child: const Icon(
                                      Icons.bookmark_border_outlined,
                                      size: 32.0,
                                    ),
                                  ),
                                );
                              },
                            )
                          // GRIDVIEW
                          : GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                mainAxisExtent: 250,
                              ),
                              itemCount: controller.room.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                Room room = controller.room[index];

                                return RsGrid(
                                  price: room.category!.price!,
                                  image: '${Api.domainUrl}/${room.image}',
                                  category: room.category!.title!,
                                  name: room.title!,
                                  icon: GestureDetector(
                                    onTap: () => print('bookmar'),
                                    child: const Icon(
                                      Icons.bookmark_outline_rounded,
                                      size: 28.0,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  );
                },
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
