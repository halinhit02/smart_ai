import 'dart:async';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:smart_ai/data/repository/message_repo.dart';
import 'package:smart_ai/model/message_create_model.dart';
import 'package:smart_ai/model/message_model.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

class MessageController extends GetxController {
  MessageRepo messageRepo;

  MessageController({required this.messageRepo});

  RxList<MessageModel> messageList = <MessageModel>[].obs;
  Rx<MessageCreateModel?> latestMessage = Rx(null);
  RxBool generating = false.obs;
  StreamSubscription<MessageCreateModel>? messageStreamSub;

  Future getAllMessages(int chatId) async {
    try {
      messageList.value = await messageRepo.getAllMessages(chatId);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('>>> Get all messages error: $e');
      }
      DialogHelpers.showErrorMessage(e.toString());
    }
  }

  Future createMessage(String modelId, String content, int chatId, {String? instruction}) async {
    if (modelId.isEmpty) {
      DialogHelpers.showErrorMessage('Cannot fetch model.');
      return;
    } else if (content.isEmpty) {
      DialogHelpers.showErrorMessage('Message not empty.');
      return;
    }
    try {
      MessageCreateModel messageCreateModel = MessageCreateModel(
          content: content, typeMessage: 'user', chatId: chatId);
      generating.value = true;
      var messageResponse =
          await messageRepo.createMessageRemote(messageCreateModel);
      messageList.add(messageResponse);
      if (modelId.contains('gpt')) {
        Stream<MessageCreateModel> messageStream =
            messageRepo.createGPTMessage(modelId, messageList, instruction: instruction);
        messageStreamSub = messageStream.listen((messageModel) async {
          var message = MessageCreateModel(
            content: messageModel.content,
            typeMessage: OpenAIChatMessageRole.assistant.name,
            chatId: chatId,
          );
          if (latestMessage.value == null) {
            latestMessage.value = message;
          } else {
            latestMessage.value = message
              ..content = latestMessage.value!.content + messageModel.content;
          }
        }, onDone: () async {
          generating.value = false;
          if (latestMessage.value != null) {
            var messageResponse =
                await messageRepo.createMessageRemote(latestMessage.value!);
            messageList.add(messageResponse);
            latestMessage.value = null;
          }
        }, onError: (e) {
          debugPrint('>>> Create message error: $e');
          generating.value = false;
          DialogHelpers.showErrorMessage(
              'Cannot create message, please try again.');
        });
      } else {
        var messageCreateModel =
            await messageRepo.createGeminiMessage(modelId, messageList);
        messageCreateModel.chatId = chatId;
        var messageModel =
            await messageRepo.createMessageRemote(messageCreateModel);
        messageList.add(messageModel);
        generating.value = false;
      }
    } catch (err) {
      debugPrint('>>> Create message error: $err');
      DialogHelpers.showMessage('Something went wrong. Try again.',
          error: true);
      generating.value = false;
    }
  }

  Future cancelGenerating() async {
    await messageStreamSub?.cancel();
    generating.value = false;
    if (latestMessage.value != null) {
      var messageResponse =
      await messageRepo.createMessageRemote(latestMessage.value!);
      messageList.add(messageResponse);
      latestMessage.value = null;
    }
  }

  Future<List<GeminiModel>> getListGeminiModel() async {
    return await messageRepo.geminiRepo.getListModel();
  }
}
