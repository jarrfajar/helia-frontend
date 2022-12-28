import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/models/roomsdetail.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:helia/app/routes/app_pages.dart';

class ConfirmReservasiController extends GetxController {
  RxBool isLoading = false.obs;

  final room = RxList<RoomsDetail>();

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

  // DATE FORMAT
  String dateformat(string) {
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(string);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM dd, yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  // ROOM DETAILS
  Future<List<RoomsDetail>> getRoomDetail(id) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      isLoading.value = true;
      if (room.isEmpty) {
        // GET TOKEN FROM LOCAL MEMORY
        String? token = prefs.getString('token');

        Uri url = Uri.parse('${Api.baseUrl}/room/$id');
        var response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        final List<RoomsDetail> data = (json.decode(response.body) as Map<String, dynamic>)['data']
            .map((json) => RoomsDetail.fromJson(json))
            .toList()
            .cast<RoomsDetail>();

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

  // BOOKING
  void booking({
    required int roomId,
    required int categoryId,
    required String phone,
    required String checkin,
    required String checkout,
    required int night,
    required String price,
    required String tax,
    required String total,
  }) async {
    try {
      // GET TOKEN FROM LOCAL MEMORY
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? idUser = prefs.getString('id');

      isLoading.value = true;
      // transactionID.value = '';
      Uri url = Uri.parse('${Api.baseUrl}/transaction');

      final body = {
        'room_id': roomId,
        'category_id': categoryId,
        'user_id': idUser,
        'phone': phone,
        'checkin': checkin,
        'checkout': checkout,
        'night': night,
        'price': price,
        'tax': tax,
        'total': total,
        'status': 'ongoing',
      };

      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body));

      if (response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        print(['object', data['data']['id']]);

        Get.back();
        Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            content: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.all(30.0),
                  decoration: const BoxDecoration(
                    color: ColorSelect.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_box_rounded,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Center(
                  child: Text(
                    "Booking Succesfull!",
                    style: TextStyle(
                      color: ColorSelect.green,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Center(
                  child: Text(
                    "You have successfully made payment and book the services.",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSelect.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () => Get.toNamed(Routes.TICKET, arguments: data['data']['id']),
                    child: const Text("View E-Receipt"),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSelect.greenSoft,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () => Get.toNamed(Routes.HOME),
                    child: const Text(
                      "Back to home",
                      style: TextStyle(
                        color: ColorSelect.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    } catch (e) {
      print(['error', e]);
      toast(message: 'Something wrong', color: Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }
}
