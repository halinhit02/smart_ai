import 'dart:convert';

class AssistantModel {
  int id;
  String title;
  String description;
  String model;
  String type;
  String color;
  String icon;

  AssistantModel({
    required this.id,
    required this.title,
    required this.description,
    required this.model,
    required this.type,
    required this.color,
    required this.icon,
  });

  AssistantModel copyWith({
    int? id,
    String? title,
    String? description,
    String? model,
    String? type,
    String? color,
    String? icon,
  }) =>
      AssistantModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        model: model ?? this.model,
        type: type ?? this.type,
        color: color ?? this.color,
        icon: icon ?? this.icon,
      );

  factory AssistantModel.fromRawJson(String str) => AssistantModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssistantModel.fromJson(Map<String, dynamic> json) => AssistantModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    model: 'gpt-3.5-turbo',
    type: json["type"],
    color: json["color"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "model": model,
    "type": type,
    "color": color,
    "icon": icon,
  };
}