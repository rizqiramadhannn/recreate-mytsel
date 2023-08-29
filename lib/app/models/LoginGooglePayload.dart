class LoginGooglePayload {
  final String idToken;

  LoginGooglePayload({required this.idToken});

  Map<String, dynamic> toJson() {
    return {
      'id_token': idToken,
    };
  }
}
