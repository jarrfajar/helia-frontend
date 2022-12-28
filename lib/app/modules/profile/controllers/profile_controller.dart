import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/models/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final profile = RxList<Profile>();

  RxBool isLoading = false.obs;
  RxBool isLoadingLogout = false.obs;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  // PICK AND UPLOAD IMAGE
  void pickImage() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();

      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // GET IDUSER FROM LOCAL MEMORY
        String? token = prefs.getString('token');
        String? id = prefs.getString('id');

        // UPLOAD IMAGE WITH DIO
        var formData = FormData.fromMap(
          {
            '_method': 'PUT',
            'image': await MultipartFile.fromFile(
              image!.path,
              filename: image!.name,
            ),
          },
        );
        var response = await Dio().post(
          '${Api.baseUrl}/profile/$id',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: "Change profile picture success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      update();
      isLoading.value = false;
    }
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
}
