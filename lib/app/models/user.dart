import 'package:intl/intl.dart';

class User {
  String? id;
  String? name;
  String? pulsa;
  String? phoneNumber;
  String? internet;
  String? telpon;
  String? sms;
  String? numExpDate;

  User(
      {this.id,
      this.name,
      this.pulsa,
      this.phoneNumber,
      this.internet,
      this.telpon,
      this.sms,
      this.numExpDate});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']?.toString();
    phoneNumber = json['phoneNumber']?.toString();
    numExpDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(json['expired']))
        .toString();
    pulsa =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0)
            .format(double.parse(json['pulsa']));
    internet =
        (double.parse(json['internet']) / (1024 * 1024)).toStringAsFixed(2);
    telpon = json['telpon']?.toString();
    sms = json['sms']?.toString();
  }
}
