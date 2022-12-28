import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/controllers/page_index_controller.dart';
import 'package:helia/app/models/profile.dart';
import 'package:helia/app/reusable/NavagationBar.dart';
import 'package:helia/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final PageIndexController pageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: ColorSelect.black,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                FutureBuilder(
                    future: controller.getProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Shimmer.fromColors(
                              baseColor: const Color.fromARGB(255, 230, 230, 230),
                              highlightColor: Colors.white,
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: ColorSelect.green,
                                ),
                              ),
                            ),
                            Shimmer.fromColors(
                              baseColor: const Color.fromARGB(255, 230, 230, 230),
                              highlightColor: Colors.white,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: ColorSelect.green,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      Profile profile = controller.profile.first;
                      return Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          GetBuilder<ProfileController>(
                            builder: (c) {
                              // if (profile.profile!.image != null && c.image != null) {
                              if (profile.profiles?.image != null) {
                                return ClipOval(
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.red,
                                    ),
                                    child: c.image != null
                                        ? Image.file(
                                            File(c.image!.path),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            '${Api.domainUrl}/${profile.profiles!.image}',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                );
                              } else {
                                return ClipOval(
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.blue,
                                    ),
                                    child: Image.network(
                                      'https://ui-avatars.com/api/?name=Fajar+Yasin',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          GestureDetector(
                            onTap: () => controller.pickImage(),
                            child: Obx(
                              () => Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: ColorSelect.green,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: controller.isLoading.isTrue
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Icon(
                                        Icons.edit_note_rounded,
                                        size: 30.0,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                const SizedBox(height: 10.0),
                const Text(
                  "Fajar Yasin",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "fajar@gmail.com",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Divider(),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
            child: SizedBox(
              height: 40,
              child: Row(
                children: const [
                  Icon(
                    Icons.person_outline_rounded,
                    size: 32.0,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          SizedBox(
            height: 40,
            child: Row(
              children: const [
                Icon(
                  Icons.payment,
                  size: 32.0,
                ),
                SizedBox(width: 15.0),
                Text(
                  "Payment",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          SizedBox(
            height: 40,
            child: Row(
              children: const [
                Icon(
                  Icons.notifications_none_rounded,
                  size: 32.0,
                ),
                SizedBox(width: 15.0),
                Text(
                  "Notification",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          SizedBox(
            height: 40,
            child: Row(
              children: const [
                Icon(
                  Icons.security_outlined,
                  size: 32.0,
                ),
                SizedBox(width: 15.0),
                Text(
                  "Security",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          SizedBox(
            height: 40,
            child: Row(
              children: const [
                Icon(
                  Icons.logout_outlined,
                  size: 32.0,
                  color: Colors.redAccent,
                ),
                SizedBox(width: 15.0),
                Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // BOTTOM NAVIGASI
      bottomNavigationBar: NavagationBar(
        controller: pageController.index.value,
        onChanged: (i) => pageController.changePage(i),
      ),
    );
  }
}
