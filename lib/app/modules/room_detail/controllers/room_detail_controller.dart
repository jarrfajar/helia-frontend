import 'dart:convert';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/models/roomsdetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RoomDetailController extends GetxController {
  RxBool isLoading = false.obs;

  final room = RxList<RoomsDetail>();

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
}
