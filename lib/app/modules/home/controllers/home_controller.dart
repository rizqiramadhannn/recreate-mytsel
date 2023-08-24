import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var userName = ''.obs; // Initialize with an empty string
  var phoneNumber = ''.obs;
  var numExpDate = ''.obs;
  var pulsa = ''.obs;
  var internet = ''.obs;
  var telpon = ''.obs;
  var sms = ''.obs;
  var isDataFetched = false.obs;
  var bannerUri = [].obs;

  Future<void> fetchUserData(int userId) async {
    final response = await http
        .get(Uri.parse('https://64d0b6a3ff953154bb795517.mockapi.io/user'));
    if (response.statusCode == 200) {
      final List<dynamic> userList = json.decode(response.body);
      final user = userList.firstWhere(
          (user) => user['id'] == userId.toString(),
          orElse: () => null);

      if (user != null) {
        print(response.statusCode);
        userName = user['name'].toString().obs;
        phoneNumber = user['phoneNumber'].toString().obs;
        numExpDate = DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(user['expired']))
            .toString()
            .obs;
        pulsa = NumberFormat.currency(
                locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0)
            .format(double.parse(user['pulsa']))
            .obs;
        internet = (double.parse(user['internet']) / (1024 * 1024))
            .toStringAsFixed(2)
            .obs;
        telpon = user['telpon'].toString().obs;
        sms = user['sms'].toString().obs;
        isDataFetched.value = true;
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> fetchBanner() async {
    final response = await http
        .get(Uri.parse('https://64d0b6a3ff953154bb795517.mockapi.io/banner'));
    if (response.statusCode == 200) {
      final List<dynamic> bannerList = json.decode(response.body);
      print(response.statusCode);
      for (int i = 0; i < bannerList.length; i++) {
        var current = bannerList[i];
        bannerUri.add(current['url']);
      }
      print(bannerUri);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchBanner();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
