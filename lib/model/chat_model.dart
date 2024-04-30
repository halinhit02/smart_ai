import 'dart:convert';

class ChatModel {
  int id;
  String title;
  String model;
  DateTime createdAt;
  int? userId;
  int? assistantId;

  ChatModel({
    required this.id,
    required this.title,
    required this.model,
    required this.createdAt,
    this.userId,
    this.assistantId,
  });

  factory ChatModel.fromRawJson(String str) => ChatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    id: json["id"],
    title: json["title"],
    model: json["model"],
    createdAt: DateTime.parse(json["createdAt"]).toLocal(),
    userId: json["userId"],
    assistantId: json["assistantId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "model": model,
    "createdAt": createdAt.toUtc().toIso8601String(),
    "userId": userId,
    "assistantId": assistantId,
  };
}
