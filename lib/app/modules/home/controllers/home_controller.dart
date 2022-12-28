import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/models/category.dart';
import 'package:helia/app/models/rooms.dart' as roomModels;
import 'package:helia/app/models/recent.dart' as recentModels;
import 'package:helia/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  RxBool isBookmar = false.obs;
  RxBool isUnBookmar = false.obs;

  RxInt current = 0.obs;
  RxString categories = ''.obs;

  final category = RxList<Categories>();
  final room = RxList<roomModels.Room>();
  final recent = RxList<recentModels.Recent>();

  final data = RxList<roomModels.Room>();

  // GET USERNAME AND TOKEN FROM LOCAL MEMORY
  RxString username = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      username.value = prefs.getString('name')!;
    }
  }

  @override
  void onClose() {
    // listCategory.clear();
    // listSerivce.clear();
    // dataku.clear();
    super.onClose();
  }

  // TOATS
  void toast({required String message, required Color color}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // CHANGE MENU
  void change(String title) {
    categories.value = title;
    data.clear();
    var test = room.where((element) => element.category!.title == categories.value).toList();
    data.addAll(test);
  }

  // CATEGORY
  Future<List<Categories>> getCategory() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      isLoading.value = true;
      if (category.isEmpty) {
        // GET TOKEN FROM LOCAL MEMORY
        String? token = prefs.getString('token');

        Uri url = Uri.parse('${Api.baseUrl}/category');
        var response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        final List<Categories> data = (json.decode(response.body) as Map<String, dynamic>)['data']
            .map((json) => Categories.fromJson(json))
            .toList()
            .cast<Categories>();

        if (response.statusCode == 200) {
          if (data.isNotEmpty) {
            category.addAll(data);
            // listTestCategory.addAll(data);
            // category.insert(
            //   0,
            //   Category(name: 'All'),
            // );
          }
          return category;
        }
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      isLoading.value = false;
    }
    return [];
  }

  // ROOM
  Future<List<roomModels.Room>> getRoom() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      isLoading.value = true;
      if (room.isEmpty) {
        // GET TOKEN FROM LOCAL MEMORY
        String? token = prefs.getString('token');

        Uri url = Uri.parse('${Api.baseUrl}/room');
        var response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        final List<roomModels.Room> data = (json.decode(response.body) as Map<String, dynamic>)['data']
            .map((json) => roomModels.Room.fromJson(json))
            .toList()
            .cast<roomModels.Room>();

        if (response.statusCode == 200) {
          if (data.isNotEmpty) {
            room.addAll(data);
          }
          return room;
        }
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      isLoading.value = false;
    }
    return [];
  }

  // RECENT
  Future<List<recentModels.Recent>> getRecent() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      isLoading.value = true;
      if (recent.isEmpty) {
        // GET TOKEN FROM LOCAL MEMORY
        String? token = prefs.getString('token');

        Uri url = Uri.parse('${Api.baseUrl}/recentBooking');
        var response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        final List<recentModels.Recent> data = (json.decode(response.body) as Map<String, dynamic>)['data']
            .map((json) => recentModels.Recent.fromJson(json))
            .toList()
            .cast<recentModels.Recent>();

        if (response.statusCode == 200) {
          if (data.isNotEmpty) {
            recent.addAll(data);
          }
          return recent;
        }
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      isLoading.value = false;
    }
    return [];
  }

  // BOOKMAR
  void bookmar({required int id, required int index}) {
    // ROOM
    room[index].bookmar!.add(roomModels.Bookmar(roomId: id));
    room.refresh();

    // RECENT
    recent[index].room!.bookmar!.add(recentModels.Bookmar(roomId: id));
    recent.refresh();

    toast(message: 'Bookmar', color: ColorSelect.green);
  }

  // UNBOOKMAR
  void unBookmar({required int id, required int index}) {
    // ROOM
    room[index].bookmar!.removeWhere((element) => element.roomId == id);
    room.refresh();

    // RECENT
    recent[index].room!.bookmar!.removeWhere((element) => element.roomId == id);
    recent.refresh();

    toast(message: 'Unbookmar', color: ColorSelect.green);
  }
}
