import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/models/profile.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;

  final profile = RxList<Profile>();

  final RxString birthdays = "".obs;

  final RxString gender = "".obs;
  List<String> list = ['Male', 'Female'];

  DateRangePickerController datePiceker = DateRangePickerController();

  late TextEditingController name, birthday, jk, job, phone = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    birthday = TextEditingController();
    jk = TextEditingController();
    job = TextEditingController();
    phone = TextEditingController();
  }

  @override
  void onClose() {
    name.dispose();
    birthday.dispose();
    jk.dispose();
    job.dispose();
    phone.dispose();
    super.onClose();
  }

  // DATE FORMAT
  String dateformat(string) {
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(string);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM dd, yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  // SELECT GENDER
  void selectGender(String value) {
    gender.value = value;
  }

  // GET PROFILE
  Future<List<Profile>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      isLoading.value = true;
      if (profile.isEmpty) {
        // GET TOKEN FROM LOCAL MEMORY
        String? token = prefs.getString('token');

        Uri url = Uri.parse('${Api.baseUrl}/profile');
        var response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        final List<Profile> data = (json.decode(response.body) as Map<String, dynamic>)['data']
            .map((json) => Profile.fromJson(json))
            .toList()
            .cast<Profile>();

        if (response.statusCode == 200) {
          if (data.isNotEmpty) {
            profile.addAll(data);
          }
          return profile;
        }
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      isLoading.value = false;
    }
    return [];
  }

  // UPDATE PROFILE
  void updateProfile({
    required String name,
    required String birthday,
    required String phone,
    required String jk,
    required String job,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      Get.back();
      // profile.clear();
      isLoading.value = true;
      // GET TOKEN FROM LOCAL MEMORY
      String? token = prefs.getString('token');
      String? id = prefs.getString('id');

      Uri url = Uri.parse('${Api.baseUrl}/profile/$id');

      final body = {
        '_method': 'PUT',
        'name': name,
        'birthday': birthday,
        'gender': jk,
        'job': job,
        'phone': phone,
      };

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Update Profile Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(['error', e]);
      Fluttertoast.showToast(
        msg: "Error $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
