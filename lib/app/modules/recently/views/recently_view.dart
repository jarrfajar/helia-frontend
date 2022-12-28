import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/currency_format.dart';
import 'package:helia/app/models/recent.dart';
import 'package:helia/app/reusable/bottomsheet.dart';
import 'package:helia/app/reusable/button.dart';
import 'package:helia/app/reusable/card.dart';
import 'package:helia/app/reusable/grid.dart';
import 'package:helia/app/shimmer/recent.dart';

import '../controllers/recently_controller.dart';

class RecentlyView extends GetView<RecentlyController> {
  const RecentlyView({Key? key}) : super(key: key);
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
          'Recently Booked',
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
      body: FutureBuilder(
          future: controller.getRecent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerRecent();
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => controller.isGrid.isFalse
                    // LISTVIEW
                    ? ListView.builder(
                        itemCount: controller.recent.length,
                        itemBuilder: (context, index) {
                          Recent recent = controller.recent[index];

                          return RsCard(
                            name: 'Kamar ${recent.room!.title!}',
                            image: '${Api.domainUrl}/${recent.room!.image}',
                            review: recent.room!.reviews?.length.toString() ?? '0',
                            price: CurrencyFormat.convertToIdr(int.parse(recent.room!.category!.price!), 0),
                            category: recent.room!.category!.title!,
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
                        itemCount: controller.recent.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          Recent recent = controller.recent[index];

                          return RsGrid(
                            price: CurrencyFormat.convertToIdr(int.parse(recent.room!.category!.price!), 0),
                            image: '${Api.domainUrl}/${recent.room!.image}',
                            category: recent.room!.category!.title!,
                            name: 'Kamar ${recent.room!.title!}',
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
          }),
    );
  }
}
