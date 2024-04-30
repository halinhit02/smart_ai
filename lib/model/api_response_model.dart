import 'dart:convert';

class ApiResponseModel<T> {
  bool success;
  String token;
  String message;
  T? data;

  ApiResponseModel({
    required this.success,
    this.token = '',
    required this.message,
    required this.data,
  });

  factory ApiResponseModel.fromRawJson(String str,
          [T Function(dynamic)? fromJsonFunc]) =>
      ApiResponseModel.fromJson(json.decode(str), fromJsonFunc);

  String toRawJson(Map Function(T) toJsonFunc) =>
      json.encode(toJson(toJsonFunc));

  factory ApiResponseModel.fromJson(Map<String, dynamic> json,
          [T Function(dynamic)? fromJsonFunc]) =>
      ApiResponseModel(
        success: json["success"],
        token: json["token"] ?? '',
        message: json["message"],
        data: json["data"] != null && fromJsonFunc != null
            ? fromJsonFunc(json["data"])
            : null,
      );

  Map<String, dynamic> toJson(Map Function(T) toJsonFunc) => {
        "success": success,
        "token": token,
        "message": message,
        "data": data != null ? toJsonFunc(data as T) : null,
      };
}
