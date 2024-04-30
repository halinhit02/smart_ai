import 'dart:convert';

class MessageCreateModel {
  String content;
  String typeMessage;
  int chatId;
  int? userId;

  MessageCreateModel({
    required this.content,
    required this.typeMessage,
    required this.chatId,
    this.userId,
  });

  factory MessageCreateModel.fromRawJson(String str) => MessageCreateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageCreateModel.fromJson(Map<String, dynamic> json) => MessageCreateModel(
    content: json["content"],
    typeMessage: json["typeMessage"],
    chatId: json["chatId"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "typeMessage": typeMessage,
    "chatId": chatId,
    "userId": userId,
  };
}
