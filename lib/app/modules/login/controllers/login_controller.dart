import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;

  late TextEditingController email, password;

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  void login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final pref = await SharedPreferences.getInstance();

      Uri url = Uri.parse('${Api.baseUrl}/login');
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        // GET RESPONSE
        var name = data['name'];
        var token = data['access_token'];
        var id = data['id'];

        // SAVE RESPONSE IN LOCAL MEMORY
        pref.setString('name', name);
        pref.setString('token', token);
        pref.setString('id', id.toString());

        Get.offAllNamed(Routes.HOME);
      } else {
        print(['gagal', response.body]);
        Fluttertoast.showToast(
          msg: "Register Gagal",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
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
