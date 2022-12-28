import 'dart:convert';

import 'package:get/get.dart';
import 'package:helia/api/api.dart';
import 'package:helia/app/models/ticket.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketController extends GetxController {
  RxBool isLoading = false.obs;

  final ticket = RxList<Ticket>();

  // DATE FORMAT
  String dateformat(string) {
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(string);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM dd, yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  // TICKET/QRCODE
  Future<List<Ticket>> getTicket(id) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      isLoading.value = true;
      ticket.clear();

      // GET TOKEN FROM LOCAL MEMORY
      String? token = prefs.getString('token');

      Uri url = Uri.parse('${Api.baseUrl}/transaction/$id');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final List<Ticket> data = (json.decode(response.body) as Map<String, dynamic>)['data']
          .map((json) => Ticket.fromJson(json))
          .toList()
          .cast<Ticket>();

      if (response.statusCode == 200) {
        if (data.isNotEmpty) {
          ticket.addAll(data);
        }
        return ticket;
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      isLoading.value = false;
    }
    return [];
  }
}
