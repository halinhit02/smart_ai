import 'dart:convert';

class SignUpModel {
  String phone;
  String password;
  String fullName;
  String email;
  String gender;
  DateTime? birthday;
  String address;

  SignUpModel({
    this.phone = '',
    this.password = '',
    this.fullName = '',
    this.email = '',
    this.gender = '',
    this.birthday,
    this.address = '',
  });

  factory SignUpModel.fromRawJson(String str) =>
      SignUpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        phone: json["phone"],
        password: json["password"],
        fullName: json["fullName"],
        email: json["email"],
        gender: json["gender"],
        birthday: json["birthday"] != null
            ? DateTime.parse(json["birthday"]).toLocal()
            : null,
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
        "fullName": fullName,
        "email": email,
        "gender": gender,
        "birthday": birthday?.toUtc().toIso8601String(),
        "address": address,
      };
}
