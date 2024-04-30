import 'dart:convert';

class ImageCreateModel {
  String content;
  String imagePath;
  String model;

  ImageCreateModel({
    required this.content,
    required this.imagePath,
    required this.model,
  });

  factory ImageCreateModel.fromRawJson(String str) => ImageCreateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageCreateModel.fromJson(Map<String, dynamic> json) => ImageCreateModel(
    content: json["content"],
    imagePath: json["imagePath"],
    model: json["model"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "imagePath": imagePath,
    "model": model,
  };
}
