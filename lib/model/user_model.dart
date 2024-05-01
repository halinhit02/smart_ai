import 'dart:convert';

class UserModel {
  int id;
  String phone;
  String fullName;
  String email;
  String gender;
  DateTime? birthday;
  String address;
  String? photo;

  UserModel({
    this.id = -1,
    required this.phone,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.birthday,
    required this.address,
    this.photo,
  });

  UserModel copyWith({
    int? id,
    String? phone,
    String? fullName,
    String? email,
    String? gender,
    DateTime? birthday,
    String? address,
    String? photo,
  }) =>
      UserModel(
        id: id ?? this.id,
        phone: phone ?? this.phone,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        address: address ?? this.address,
        photo: photo ?? this.photo,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? -1,
        phone: json["phone"],
        fullName: json["fullName"] ?? '',
        email: json["email"] ?? '',
        gender: json["gender"] ?? '',
        birthday: json["birthday"] != null
            ? DateTime.tryParse(json["birthday"])?.toLocal()
            : null,
        address: json["address"] ?? '',
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "fullName": fullName,
        "email": email,
        "gender": gender,
        "birthday": birthday?.toUtc().toIso8601String(),
        "address": address,
        "photo": photo,
      };
}
