import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytsel/config/api.dart';
import '../../const/storage_key.dart';
import '../routes/app_pages.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    print("onInit");
    var token = GetStorage().read(StorageKey.jwt);
    httpClient.baseUrl = api.baseUrl;
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = Duration(seconds: 60);
    httpClient.addResponseModifier((request, response) async {
      print("============ RESPONSE ============");
      print("URL Path : ${request.url.path}");
      print("Status code : ${response.status.code}");
      print("Response body : ${jsonEncode(response.body)}");
      print("Token : ${token}");
      print("============ END RESPONSE ============");

      if (response.status.code == 401 && !request.url.path.contains("login")) {
        print("Token expired");
        GetStorage().erase();
        Get.showSnackbar(GetSnackBar(
          message: "Sesi login berakhir, silahkan login kembali",
          duration: Duration(milliseconds: 3000),
        ));
        Get.offAllNamed(Routes.HOME);
      }
      return response;
    });

    var headers = {'Authorization': "Bearer $token"};
    print(headers);
    httpClient.addRequestModifier<dynamic>((request) async {
      request.headers.addAll(headers);
      return request;
    });

    super.onInit();
  }
}
