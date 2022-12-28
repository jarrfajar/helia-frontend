import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;

  late TextEditingController name, email, password, passwordConfirm;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    passwordConfirm = TextEditingController();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
    super.onClose();
  }

  // REGISTER
  void register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      isLoading.value = true;
      final pref = await SharedPreferences.getInstance();

      Uri url = Uri.parse('${Api.baseUrl}/register');
      var response = await http.post(url, body: {
        'name': name,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        // GET RESPONSE
        var name = data['data']['name'];
        var token = data['access_token'];

        // SAVE RESPONSE IN LOCAL MEMORY
        pref.setString('name', name);
        pref.setString('token', token);

        Get.offAllNamed(Routes.HOME);
        print('berhasil');
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
