import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/models/booking.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyBookingController extends GetxController {
  RxInt current = 0.obs;
  RxBool isLoading = false.obs;
  RxString status = 'ongoing'.obs;

  final booking = RxList<Booking>();

  // BOOKING
  Future<List<Booking>> getBooking() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      isLoading.value = true;
      if (booking.isEmpty) {
        // GET TOKEN FROM LOCAL MEMORY
        String? token = prefs.getString('token');

        Uri url = Uri.parse('${Api.baseUrl}/transaction');
        var response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        final List<Booking> data = (json.decode(response.body) as Map<String, dynamic>)['data']
            .map((json) => Booking.fromJson(json))
            .toList()
            .cast<Booking>();

        if (response.statusCode == 200) {
          if (data.isNotEmpty) {
            booking.addAll(data);
          }
          return booking;
        }
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      isLoading.value = false;
    }
    return [];
  }

  // CANCEL
  void cancel({required int id}) async {
    Get.back();
    try {
      isLoading.value = true;
      final pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');

      Uri url = Uri.parse('${Api.baseUrl}/transaction/$id');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        '_method': 'PUT',
        'status': 'canceled',
      });

      if (response.statusCode == 200) {
        print('succes');
        Get.back();
        var data = booking.firstWhere((element) => element.id == id);
        data.status = 'canceled';
        update();
      } else {
        print(['gagal', response.body]);
        Fluttertoast.showToast(
          msg: "Cancel Gagal",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      isLoading.value = false;
    }
  }
}
