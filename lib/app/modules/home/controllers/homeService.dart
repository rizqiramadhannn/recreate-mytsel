import 'package:get/get.dart';
import 'package:mytsel/app/api/ApiProvider.dart';

class HomeService extends ApiProvider {
  Future<Response> getUserData() => get('/user');
  Future<Response> getBanner() => get('/banner');
}
