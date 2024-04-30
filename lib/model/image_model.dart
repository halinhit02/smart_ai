import 'dart:convert';

class ImageModel {
  int id;
  String content;
  String imagePath;
  String model;
  DateTime? createdAt;
  int? userId;

  ImageModel({
    required this.id,
    required this.content,
    required this.imagePath,
    required this.model,
    required this.createdAt,
    this.userId,
  });

  factory ImageModel.fromRawJson(String str) =>
      ImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        content: json["content"],
        imagePath: json["imagePath"],
        model: json["model"],
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])?.toLocal()
            : null,
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "imagePath": imagePath,
        "model": model,
        "createdAt": createdAt?.toUtc().toIso8601String(),
        "userId": userId,
      };
}
