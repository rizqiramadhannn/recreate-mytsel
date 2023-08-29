import 'package:get/get_connect/http/src/response/response.dart';

import '../../../api/ApiProvider.dart';
import '../../../models/LoginGooglePayload.dart';
import '../../../models/LoginGoogleResponse.dart';
import '../../../models/LoginPayload.dart';
import '../../../models/LoginResponse.dart';

class LoginService extends ApiProvider {
  Future<Response<LoginResponse>> Login(LoginPayload payload) =>
      post<LoginResponse>('api/v1/login', payload.toJson(),
          decoder: (obj) => LoginResponse.fromJson(obj));

  Future<Response<LoginGoogleResponse>> LoginGoogle(
          LoginGooglePayload payload) =>
      post<LoginGoogleResponse>('api/v1/login_google', payload.toJson(),
          decoder: (obj) => LoginGoogleResponse.fromJson(obj));
}
