import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mytsel/app/api/ApiProvider.dart';
import 'homeService.dart';
import '../../../models/user.dart';

class HomeController extends GetxController {
  final HomeService _homeService = GetInstance().find<HomeService>();
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
      } else {
        userData = User.fromJson(response.body as Map<String, dynamic>).obs;
        isDataFetched.value = true;
      }
    } catch (e) {
      print("Exception: $e");
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
