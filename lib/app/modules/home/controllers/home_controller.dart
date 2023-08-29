import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mytsel/app/api/ApiProvider.dart';
import 'homeService.dart';
import '../../../models/user.dart';

class HomeController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();
  final HomeService _homeService = HomeService();
  Rx<User> userData = Rx<User>(User(id: ''));
  var isDataFetched = false.obs;
  var bannerUri = [].obs;
  var selectedLanguage = Get.locale?.languageCode.obs;

  set changeLanguage(String? lang) {
    if (lang != null) {
      Locale locale = Locale(lang);
      Get.updateLocale(locale);
      selectedLanguage?.value = lang;
    }
  }

  Future<void> fetchUserData(int userId) async {
    try {
      var response = await _homeService.getUserData(userId);

      if (response.status.hasError) {
        print("Error: ${response.statusText}");
        // Handle error if needed
      } else {
        var userJson = response.body as Map<String, dynamic>;
        userData = User(
          id: userJson['id'],
          name: userJson['name']?.toString(),
          phoneNumber: userJson['phoneNumber']?.toString(),
          numExpDate: DateFormat('dd-MM-yyyy')
              .format(DateTime.parse(userJson['expired']))
              .toString(),
          pulsa: NumberFormat.currency(
                  locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0)
              .format(double.parse(userJson['pulsa'])),
          internet: (double.parse(userJson['internet']) / (1024 * 1024))
              .toStringAsFixed(2),
          telpon: userJson['telpon']?.toString(),
          sms: userJson['sms']?.toString(),
        ).obs; // Assign the User object to userData
        isDataFetched.value = true;
      }
    } catch (e) {
      print("Exception: $e");
      // Handle exceptions// Replace with the appropriate error handling
    }
  }

  Future<void> fetchBanner() async {
    try {
      var response = await _homeService.getBanner();
      if (response.status.hasError) {
        print("Error: ${response.statusText}");
        // Handle error if needed
      } else {
        print(response.body);
        var bannerList = response.body;
        for (int i = 0; i < bannerList.length; i++) {
          print((bannerList[i])['url']);
          bannerUri.add((bannerList[i])['url']);
        }
      }
    } catch (e) {
      print("Exception: $e");
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
