import 'package:get/get.dart';
import 'package:mytsel/app/api/ApiProvider.dart';

class HomeService extends ApiProvider {
  Future<Response> getUserData(int id) => get('user/${id}');
  Future<Response> getBanner() => get('/banner');
}
