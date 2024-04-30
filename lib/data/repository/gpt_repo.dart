import 'dart:io';

import 'package:dart_openai/dart_openai.dart';

class GPTRepo {
  Future<List<OpenAIModelModel>> getChatCompletionModel() async {
    return await OpenAI.instance.model.list();
  }

  Future<OpenAIModelModel> getAIModel(String modelId) {
    return OpenAI.instance.model.retrieve(modelId);
  }

  Future<OpenAICompletionModel> createCompletion(String modelId, String prompt,
      {int maxTokens = 200, double temperature = 0.9}) async {
    OpenAICompletionModel completion = await OpenAI.instance.completion.create(
      model: modelId,
      prompt: prompt,
      maxTokens: maxTokens,
      temperature: temperature,
      n: 1,
      echo: true,
    );
    return completion;
  }

  Stream<OpenAIStreamCompletionModel> createCompletionStream(
      String modelId, String prompt,
      {int maxTokens = 200, double temperature = 0.9}) {
    Stream<OpenAIStreamCompletionModel> completionStream =
        OpenAI.instance.completion.createStream(
      model: modelId,
      prompt: prompt,
      maxTokens: maxTokens,
      temperature: temperature,
      n: 1,
    );
    return completionStream;
  }

  Stream<OpenAIStreamChatCompletionModel> createChatCompletionStream(
      String modelId, List<OpenAIChatCompletionChoiceMessageModel> messages,
      {int maxTokens = 4000, double temperature = 0.9}) {
    final chatStream = OpenAI.instance.chat.createStream(
      model: modelId,
      messages: messages,
      temperature: temperature,
      maxTokens: maxTokens,
    );
    return chatStream;
  }

  Future<OpenAIImageModel> createImage(
    String prompt, {
    int number = 1,
    OpenAIImageSize size = OpenAIImageSize.size512,
    OpenAIImageStyle style = OpenAIImageStyle.natural,
    OpenAIImageQuality quality = OpenAIImageQuality.hd,
  }) async {
    OpenAIImageModel image = await OpenAI.instance.image.create(
      prompt: prompt,
      n: number,
      size: size,
      responseFormat: OpenAIImageResponseFormat.url,
      style: OpenAIImageStyle.natural,
      quality: quality,
    );
    return image;
  }

  Future<OpenAIImageModel> createImageEdit(
    String prompt,
    File image, {
    File? mask,
    int number = 1,
    OpenAIImageSize size = OpenAIImageSize.size512,
  }) async {
    OpenAIImageModel imageEdits = await OpenAI.instance.image.edit(
      prompt: prompt,
      image: image,
      mask: mask,
      n: number,
      size: size,
      responseFormat: OpenAIImageResponseFormat.url,
    );
    return imageEdits;
  }
}
