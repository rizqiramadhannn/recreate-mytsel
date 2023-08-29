import 'package:get/get.dart';
import 'package:mytsel/app/api/ApiProvider.dart';

import '../../../models/user.dart';
import 'package:mytsel/config/api.dart';

class HomeService extends ApiProvider {
  onInit();
  Future<Response> getUserData(int id) => get('${api.baseUrl}user/${id}');
  Future<Response> getBanner() => get('${api.baseUrl}banner');
}
