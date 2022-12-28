import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/models/bookmars.dart';
import 'package:helia/app/modules/home/controllers/home_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookmarController extends GetxController {
  final HomeController homeController = Get.find();

  RxBool isLoading = false.obs;
  RxBool isGrid = false.obs;

  final bookmar = RxList<Bookmars>();

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

  // BOOKMAR
  Future<List<Bookmars>> getBookmar() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      isLoading.value = true;
      if (bookmar.isEmpty) {
        // GET TOKEN FROM LOCAL MEMORY
        String? token = prefs.getString('token');

        Uri url = Uri.parse('${Api.baseUrl}/bookmars');
        var response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        final List<Bookmars> data = (json.decode(response.body) as Map<String, dynamic>)['data']
            .map((json) => Bookmars.fromJson(json))
            .toList()
            .cast<Bookmars>();

        if (response.statusCode == 200) {
          if (data.isNotEmpty) {
            bookmar.addAll(data);
          }
          return bookmar;
        }
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      isLoading.value = false;
    }
    return [];
  }

  // UNBOOKMAR
  void unBookmar({required int id}) {
    bookmar.removeWhere((element) => element.id == id);
    Get.back();
    bookmar.refresh();

    // REMOVE BOOKMAR FROM HOMEPAGE
    // ROOM
    var dataRoom = homeController.room.where((element) => element.id == id);
    dataRoom.first.bookmar!.removeWhere((element) => element.roomId == id);
    homeController.room.refresh();

    // RECENT
    var dataRecent = homeController.recent.where((element) => element.roomId == id);
    dataRecent.first.room!.bookmar!.removeWhere((element) => element.roomId == id);
    homeController.recent.refresh();

    // toast(message: 'Unbookmar', color: ColorSelect.green);
  }
}
