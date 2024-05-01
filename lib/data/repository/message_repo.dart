import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_ai/data/repository/gemini_repo.dart';
import 'package:smart_ai/data/repository/gpt_repo.dart';
import 'package:smart_ai/model/message_create_model.dart';
import 'package:smart_ai/model/message_model.dart';

import '../data_source/remote/message_remote_source.dart';

class MessageRepo {
  GPTRepo gptRepo;
  GeminiRepo geminiRepo;
  MessageRemoteSource messageRemoteSource;

  MessageRepo({
    required this.gptRepo,
    required this.geminiRepo,
    required this.messageRemoteSource,
  });

  Stream<MessageCreateModel> createGPTMessage(
      String modelId, List<MessageModel> messageList,
      {String? instruction}) {
    var chatCompleteMessages = messageList
        .where((e) => e.typeMessage.contains(OpenAIChatMessageRole.user.name))
        .map((e) => OpenAIChatCompletionChoiceMessageModel(
              role: e.typeMessage.contains('user')
                  ? OpenAIChatMessageRole.user
                  : OpenAIChatMessageRole.assistant,
              content: [
                OpenAIChatCompletionChoiceMessageContentItemModel.text(
                    e.content)
              ],
            ))
        .toList();
    if (instruction != null && instruction.isNotEmpty) {
      chatCompleteMessages.insert(
          0,
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.system,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                  instruction)
            ],
          ));
    }
    var result = gptRepo
        .createChatCompletionStream(modelId, chatCompleteMessages)
        .delay(const Duration(milliseconds: 500))
        .map((event) => MessageCreateModel(
              content: event.choices.first.delta.content?.first?.text ?? '',
              typeMessage: 'assistant',
              chatId: -1,
            ));
    return result;
  }

  Future<MessageCreateModel> createGeminiMessage(
      String modelId, List<MessageModel> messageList) async {
    var contents = messageList
        .map((e) => e.typeMessage == 'user'
            ? Content(parts: [Parts(text: e.content)], role: e.typeMessage)
            : Content(parts: [Parts(text: e.content)], role: 'model'))
        .toList();
    var resultMessage = await geminiRepo.generateChatMessage(contents);
    return MessageCreateModel(
      content: resultMessage?.content?.parts?.first.text ?? '',
      typeMessage: 'model',
      chatId: -1,
    );
  }

  Future<MessageModel> createMessageRemote(
      MessageCreateModel messageCreateModel) async {
    var messageResponse =
        await messageRemoteSource.createMessage(messageCreateModel);
    if (messageResponse.success && messageResponse.data != null) {
      return messageResponse.data!;
    } else {
      return Future.error(messageResponse.message);
    }
  }

  Future<List<MessageModel>> getAllMessages(int chatId) async {
    var messageResponse = await messageRemoteSource.getAllMessages(chatId);
    if (messageResponse.success && messageResponse.data != null) {
      return messageResponse.data!;
    } else {
      return Future.error(messageResponse.message);
    }
  }
}
