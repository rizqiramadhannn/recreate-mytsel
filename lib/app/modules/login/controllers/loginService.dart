import 'package:get/get_connect/http/src/response/response.dart';

import '../../../api/ApiProvider.dart';
import '../../../models/LoginGooglePayload.dart';
import '../../../models/LoginGoogleResponse.dart';
import '../../../models/LoginPayload.dart';
import '../../../models/LoginResponse.dart';

class LoginService extends ApiProvider {
  Future<Response> Login(LoginPayload payload) =>
      post('/login', payload.toJson());
  Future<Response> getUserData(String email) => get('/user/${email}');
  Future<Response<LoginGoogleResponse>> LoginGoogle(
          LoginGooglePayload payload) =>
      post<LoginGoogleResponse>('/login_google', payload.toJson(),
          decoder: (obj) => LoginGoogleResponse.fromJson(obj));
}
