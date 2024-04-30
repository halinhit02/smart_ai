import 'dart:convert';

class MessageModel {
  int id;
  String content;
  String typeMessage;
  DateTime? createdAt;
  int chatId;
  int? userId;

  MessageModel({
    required this.id,
    required this.content,
    required this.typeMessage,
    required this.createdAt,
    required this.chatId,
    this.userId,
  });

  factory MessageModel.fromRawJson(String str) =>
      MessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        content: json["content"],
        typeMessage: json["typeMessage"],
        createdAt: json["createdAt"] == null
            ? DateTime.parse(json["createdAt"]).toLocal()
            : null,
        chatId: json["chatId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "typeMessage": typeMessage,
        "createdAt": createdAt?.toUtc().toIso8601String(),
        "chatId": chatId,
        "userId": userId,
      };
}
