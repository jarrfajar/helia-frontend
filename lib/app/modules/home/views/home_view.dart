import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/controllers/auth_controller.dart';
import 'package:helia/app/controllers/page_index_controller.dart';
import 'package:helia/app/currency_format.dart';
import 'package:helia/app/models/category.dart';
import 'package:helia/app/models/recent.dart';
import 'package:helia/app/models/rooms.dart' as roomModels;

import 'package:helia/app/reusable/NavagationBar.dart';
import 'package:helia/app/reusable/card.dart';
import 'package:helia/app/routes/app_pages.dart';
import 'package:helia/app/shimmer/category.dart';
import 'package:helia/app/shimmer/listkamar.dart';
import 'package:helia/app/shimmer/recent.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final PageIndexController pageController = Get.find();

  @override
  Widget build(BuildContext context) {
    // print(100000 * 10 / 100);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Hello, Fajar Yasin",
                  style: TextStyle(
                    color: ColorSelect.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.BOOKMAR),
                  child: const Icon(
                    Icons.bookmark_border_rounded,
                    size: 34.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // SEARCH
            GestureDetector(
              onTap: () => Get.toNamed(Routes.SEARH),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    ),
                    Text("Search"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            Column(
              children: [
                // CATEGORY
                FutureBuilder(
                  future: controller.getCategory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ShimmerCategory();
                    }
                    return SizedBox(
                      height: 40.0,
                      child: ListView.builder(
                        itemCount: controller.category.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Categories category = controller.category[index];

                          return Obx(
                            () => GestureDetector(
                              onTap: () => controller.change(category.title!),
                              child: Container(
                                width: 100.0,
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  color:
                                      controller.categories.value == category.title! ? ColorSelect.green : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0),
                                  ),
                                  border: Border.all(
                                    color: ColorSelect.green,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    category.title!,
                                    style: TextStyle(
                                      // color: ColorSelect.green,
                                      color: controller.categories.value != category.title!
                                          ? ColorSelect.green
                                          : Colors.white,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            // KAMAR
            FutureBuilder(
              future: controller.getRoom(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimmerListKamar();
                }

                return Obx(
                  () => SizedBox(
                    height: 350.0,
                    child: ListView.builder(
                      itemCount: controller.categories.value == '' ? controller.room.length : controller.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // roomModels.Room rooms = controller.room[index];
                        roomModels.Room rooms =
                            controller.categories.value == '' ? controller.room[index] : controller.data[index];

                        return GestureDetector(
                          onTap: () => Get.toNamed(
                            Routes.ROOM_DETAIL,
                            arguments: rooms.id,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: '${Api.domainUrl}/${rooms.image}',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 230.0,
                              // padding: const EdgeInsets.all(20.0),
                              margin: const EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                color: Colors.blueAccent,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(.5),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(
                                          () => Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              rooms.bookmar!.isEmpty
                                                  ? GestureDetector(
                                                      onTap: () => controller.bookmar(id: rooms.id!, index: index),
                                                      child: controller.isBookmar.isFalse
                                                          ? const Icon(
                                                              Icons.bookmark_border,
                                                              size: 36,
                                                              color: Colors.white,
                                                            )
                                                          : const SizedBox(
                                                              height: 25,
                                                              width: 25,
                                                              child: CircularProgressIndicator(
                                                                strokeWidth: 3,
                                                                color: Colors.blueAccent,
                                                              ),
                                                            ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () => controller.unBookmar(id: rooms.id!, index: index),
                                                      child: controller.isUnBookmar.isFalse
                                                          ? const Icon(
                                                              Icons.bookmark,
                                                              color: ColorSelect.green,
                                                              size: 36,
                                                            )
                                                          : const SizedBox(
                                                              height: 25,
                                                              width: 25,
                                                              child: CircularProgressIndicator(
                                                                strokeWidth: 3,
                                                                color: Colors.blueAccent,
                                                              ),
                                                            ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Kamar ${rooms.title}",
                                              style: const TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              rooms.category!.title!,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${CurrencyFormat.convertToIdr(int.parse(rooms.category!.price!), 0)} ',
                                                    style: const TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '/ night',
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: const Color.fromARGB(255, 230, 230, 230),
                              highlightColor: Colors.white,
                              child: Container(
                                width: 230.0,
                                margin: const EdgeInsets.only(right: 20.0),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 236, 236, 236),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20.0,
            ),

            // RECENTLY HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recently Booked",
                  style: TextStyle(
                    color: ColorSelect.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.RECENTLY),
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: ColorSelect.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),

            // RECENTLY BODY
            FutureBuilder(
              future: controller.getRecent(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerRecent();
                }
                return Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.recent.length >= 5 ? 5 : controller.recent.length,
                    itemBuilder: (context, index) {
                      Recent recent = controller.recent[index];

                      return RsCard(
                        name: 'Kamar ${recent.room!.title!}',
                        image: '${Api.domainUrl}/${recent.room!.image}',
                        review: recent.room!.reviews?.length.toString() ?? '0',
                        price: CurrencyFormat.convertToIdr(int.parse(recent.room!.category!.price!), 0),
                        category: recent.room!.category!.title!,
                        icon: recent.room!.bookmar!.isEmpty
                            ? GestureDetector(
                                onTap: () => controller.bookmar(id: recent.room!.id!, index: index),
                                child: controller.isBookmar.isFalse
                                    ? const Icon(
                                        Icons.bookmark_border,
                                        size: 32,
                                      )
                                    : const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                              )
                            : GestureDetector(
                                onTap: () => controller.unBookmar(id: recent.room!.id!, index: index),
                                child: controller.isUnBookmar.isFalse
                                    ? const Icon(
                                        Icons.bookmark,
                                        color: ColorSelect.green,
                                        size: 32,
                                      )
                                    : const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                              ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
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
