import 'dart:io';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_gemini/src/models/candidates/candidates.dart';

class GeminiRepo {
  final gemini = Gemini.instance;

  Future<List<GeminiModel>> getListModel() async {
    return await gemini.listModels();
  }

  Stream<Candidates> generateContent(
    String message, {
    List<File>? images,
    String? modelName,
    double temperature = 0.9,
    int? maxTokens,
  }) {
    return gemini.streamGenerateContent(message,
        images: images?.map((e) => e.readAsBytesSync()).toList(),
        modelName: modelName,
        generationConfig: GenerationConfig(
          temperature: temperature,
          maxOutputTokens: maxTokens,
        ));
  }

  Future<Candidates?> generateText(String input) async {
    return await gemini.text(input);
  }

  Future<Candidates?> generateChatMessage(
    List<Content> messages, {
    List<File>? images,
    String? modelName,
    double temperature = 0.9,
    int? maxTokens,
  }) async {
    return await gemini.chat(messages,
        modelName: modelName,
        generationConfig: GenerationConfig(
          temperature: temperature,
          maxOutputTokens: maxTokens,
        ));
  }

  Future<Candidates?> generateTextImage(
    String message,
    List<File> images, {
    String? modelName,
    double temperature = 0.9,
    int? maxTokens,
  }) {
    return gemini.textAndImage(
        text: message,
        images: images.map((e) => e.readAsBytesSync()).toList(),
        generationConfig: GenerationConfig(
          temperature: temperature,
          maxOutputTokens: maxTokens,
        ));
  }
}
