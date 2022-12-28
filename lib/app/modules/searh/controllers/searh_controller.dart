import 'dart:convert';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/models/rooms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SearhController extends GetxController {
  RxBool isGrid = false.obs;
  RxString search = ''.obs;
  RxBool isLoading = false.obs;

  final room = RxList<Room>();
  final cari = RxList<Room>();

  void searching(value) {
    cari.clear();

    // var data = room.where((element) => element.title.toString().toLowerCase().contains(value.toLowerCase())).toList();
    var data = room
        .where((element) =>
            element.title.toString().toLowerCase().contains(value.toLowerCase()) ||
            element.category!.title!.toString().toLowerCase().contains(value.toLowerCase()))
        .toList();

    cari.addAll(data);
  }

  // ROOM
  Future<List<Room>> getRoom() async {
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

        final List<Room> data = (json.decode(response.body) as Map<String, dynamic>)['data']
            .map((json) => Room.fromJson(json))
            .toList()
            .cast<Room>();

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
}
