import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/currency_format.dart';
import 'package:helia/app/models/roomsdetail.dart';
import 'package:helia/app/reusable/button.dart';
import 'package:helia/app/routes/app_pages.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/room_detail_controller.dart';

class RoomDetailView extends GetView<RoomDetailController> {
  final int id = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: controller.getRoomDetail(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          RoomsDetail room = controller.room.first;

          return Stack(
            children: [
              ListView(
                children: [
                  Stack(
                    children: [
                      // Container(
                      //   height: Get.height * 0.3,
                      //   color: Colors.red,
                      // ),
                      CachedNetworkImage(
                        imageUrl: '${Api.domainUrl}/${room.image}',
                        imageBuilder: (context, imageProvider) => Container(
                          height: Get.height * 0.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            color: Colors.blueAccent,
                          ),
                          // child: ,
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 230, 230, 230),
                          highlightColor: Colors.white,
                          child: Container(
                            height: Get.height * 0.3,
                            margin: const EdgeInsets.only(right: 20.0),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                            ),
                          ),
                        ),
                      ),

                      // BACK
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 50,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(87, 0, 0, 0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              size: 32.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kamar ${room.title}",
                              style: const TextStyle(
                                color: ColorSelect.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 80,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 214, 243, 225),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  room.category!.title!,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    color: ColorSelect.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: ColorSelect.black,
                            ),
                            children: [
                              TextSpan(
                                text: '${CurrencyFormat.convertToIdr(int.parse(room.category!.price!), 0)} ',
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
                        const SizedBox(height: 10.0),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 10.0),

                        // DETAILS
                        const Text(
                          "Details",
                          style: TextStyle(
                            color: ColorSelect.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          height: 80.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.hotel,
                                        size: 35.0,
                                        color: ColorSelect.green,
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        "2 Bedroom",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.elevator_outlined,
                                        size: 35.0,
                                        color: ColorSelect.green,
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        "Elevator",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.wifi_rounded,
                                        size: 35.0,
                                        color: ColorSelect.green,
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        "Wifi",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.restaurant,
                                        size: 35.0,
                                        color: ColorSelect.green,
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        "Restaurant",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),

                        // DESCRIPTION
                        const Text(
                          "Description",
                          style: TextStyle(
                            color: ColorSelect.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        ReadMoreText(
                          room.description!,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          lessStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15.0),

                        // REVIEW
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Review",
                              style: TextStyle(
                                color: ColorSelect.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(Routes.REVIEWS, arguments: id),
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
                        const SizedBox(height: 10.0),
                        ListView.builder(
                          itemCount: room.reviews!.length >= 5 ? 5 : room.reviews!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            Reviews review = room.reviews![index];

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: Colors.red,
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                review.user!.name!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              const Text("Dec 10, 2022"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 35,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          color: ColorSelect.green,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.star_rate_rounded,
                                                size: 20.0,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 5.0),
                                              Text(
                                                review.rating.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  ReadMoreText(
                                    review.description!,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    lessStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80.0),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RsButton(
                    onPress: () => Get.toNamed(Routes.ROOM_BOOKING, arguments: [id, room.category!.price]),
                    color: ColorSelect.green,
                    isLoading: controller.isLoading.isTrue,
                    label: 'Book Now',
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
