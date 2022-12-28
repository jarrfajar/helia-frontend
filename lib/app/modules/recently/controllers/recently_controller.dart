import 'dart:convert';

import 'package:helia/api/api.dart';
import 'package:helia/app/models/recent.dart' as recentModels;
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentlyController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isGrid = false.obs;

  final recent = RxList<recentModels.Recent>();

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
}
