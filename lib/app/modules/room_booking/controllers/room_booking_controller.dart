import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RoomBookingController extends GetxController {
  RxBool isLoading = false.obs;

  RxString rxStartDate = ''.obs;
  RxString rxEndDate = ''.obs;

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

  // WITH DATETIME
  RxString startDate = 'Select Date'.obs;
  RxString endDate = 'Select Date'.obs;
  RxInt countDate = 0.obs;

  // COUNT PRICE
  int countPrice(price, countDate) {
    int total = price * countDate;
    return total;
  }

  // DATE FORMAT
  String dateformat(string) {
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(string);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  // COUNT DATE
  int countBeetweenDate(startDate, endDate) {
    DateTime start = DateFormat("yyyy-MM-dd HH:mm:ss").parse(startDate);
    DateTime end = DateFormat("yyyy-MM-dd HH:mm:ss").parse(endDate);

    DateTime dateTimeCreatedAt = DateTime.parse(start.toString());
    DateTime dateTimeNow = DateTime.parse(end.toString());
    final differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;

    if (differenceInDays == 0) {
      return 1;
    }
    return differenceInDays;
  }
}
