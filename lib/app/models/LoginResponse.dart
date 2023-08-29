class LoginResponse {
  String? msg;
  String? rc;
  String? token;

  LoginResponse({this.msg, this.rc, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    rc = json['rc'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['rc'] = this.rc;
    data['token'] = this.token;
    return data;
  }
}
