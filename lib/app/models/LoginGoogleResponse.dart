import 'user.dart';

class LoginGoogleResponse {
  final String accessToken;
  final String refreshToken;
  final User user; // Assuming you have a User class

  LoginGoogleResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginGoogleResponse.fromJson(Map<String, dynamic> json) {
    return LoginGoogleResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      user: User.fromJson(json['user']),
    );
  }
}
