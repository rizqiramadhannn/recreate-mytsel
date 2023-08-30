import 'package:intl/intl.dart';

class User {
  int? id;
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
    id = json['ID'];
    name = json['Name']?.toString();
    phoneNumber = json['PhoneNumber']?.toString();
    numExpDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(json['Expired'].split(' ')[0]))
        .toString();
    ;
    pulsa =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0)
            .format(double.parse(json['Pulsa']));
    internet =
        (double.parse(json['Internet']) / (1024 * 1024)).toStringAsFixed(2);
    telpon = json['Telpon']?.toString();
    sms = json['SMS']?.toString();
  }
}
