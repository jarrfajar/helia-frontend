import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/currency_format.dart';
import 'package:helia/app/models/bookmars.dart';
import 'package:helia/app/reusable/bottomsheet.dart';
import 'package:helia/app/reusable/card.dart';
import 'package:helia/app/reusable/grid.dart';

import '../controllers/bookmar_controller.dart';

class BookmarView extends GetView<BookmarController> {
  const BookmarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'My Bookmar',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                Icons.my_library_books_sharp,
                size: 30,
                color: controller.isGrid.isFalse ? ColorSelect.green : const Color.fromARGB(255, 150, 142, 142),
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
                color: controller.isGrid.isTrue ? ColorSelect.green : const Color.fromARGB(255, 150, 142, 142),
              ),
            ),
            tooltip: 'Open shopping cart',
            onPressed: () => controller.isGrid.value = true,
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: controller.getBookmar(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Obx(
              () => controller.isGrid.isFalse
                  // LISTVIEW
                  ? ListView.builder(
                      itemCount: controller.bookmar.length,
                      itemBuilder: (context, index) {
                        Bookmars bookmars = controller.bookmar[index];

                        return RsCard(
                          name: 'Kamar ${bookmars.title!}',
                          image: '${Api.domainUrl}/${bookmars.image}',
                          review: bookmars.reviews!.length.toString(),
                          price: CurrencyFormat.convertToIdr(int.parse(bookmars.category!.price!), 0),
                          category: bookmars.category!.title!,
                          icon: GestureDetector(
                            onTap: () => Get.bottomSheet(
                              RsBottomSheet(
                                height: Get.height * 0.4,
                                title: "Remove from Bookmar?",
                                cancel: "cancel",
                                yes: "Yes, Remove",
                                widget: RsCard(
                                  name: 'Kamar ${bookmars.title!}',
                                  image: '${Api.domainUrl}/${bookmars.image}',
                                  review: bookmars.reviews!.length.toString(),
                                  price: CurrencyFormat.convertToIdr(int.parse(bookmars.category!.price!), 0),
                                  category: bookmars.category!.title!,
                                  icon: const Icon(
                                    Icons.bookmark_outlined,
                                    size: 36.0,
                                    color: ColorSelect.green,
                                  ),
                                ),
                                isLoading: controller.isLoading.isTrue,
                                onPressCancel: () => Get.back(),
                                onPressYes: () => controller.unBookmar(id: bookmars.id!),
                              ),
                            ),
                            child: const Icon(
                              Icons.bookmark_outlined,
                              size: 36.0,
                              color: ColorSelect.green,
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
                      itemCount: controller.bookmar.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        Bookmars bookmars = controller.bookmar[index];

                        return RsGrid(
                          name: 'Kamar ${bookmars.title!}',
                          image: '${Api.domainUrl}/${bookmars.image}',
                          price: CurrencyFormat.convertToIdr(int.parse(bookmars.category!.price!), 0),
                          category: bookmars.category!.title!,
                          icon: GestureDetector(
                            onTap: () => Get.bottomSheet(
                              RsBottomSheet(
                                height: Get.height * 0.4,
                                title: "Remove from Bookmar?",
                                cancel: "cancel",
                                yes: "Yes, Remove",
                                widget: RsCard(
                                  name: 'Kamar ${bookmars.title!}',
                                  image: '${Api.domainUrl}/${bookmars.image}',
                                  review: bookmars.reviews!.length.toString(),
                                  price: CurrencyFormat.convertToIdr(int.parse(bookmars.category!.price!), 0),
                                  category: bookmars.category!.title!,
                                  icon: const Icon(
                                    Icons.bookmark_outlined,
                                    size: 36.0,
                                    color: ColorSelect.green,
                                  ),
                                ),
                                isLoading: controller.isLoading.isTrue,
                                onPressCancel: () => Get.back(),
                                onPressYes: () => controller.unBookmar(id: bookmars.id!),
                              ),
                            ),
                            child: const Icon(
                              Icons.bookmark_outlined,
                              size: 28.0,
                              color: ColorSelect.green,
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
