import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smart_ai/data/repository/chat_repo.dart';
import 'package:smart_ai/model/chat_model.dart';
import 'package:smart_ai/utils/constants/app_config.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

class ChatController extends GetxController {
  ChatRepo chatRepo;

  ChatController({
    required this.chatRepo,
  });

  late String selectedModel;
  RxBool createLoading = false.obs;
  RxBool getChatLoading = false.obs;
  List<String> chatModels = [];
  List<String> chatModelName = [];
  RxList<ChatModel> chatList = <ChatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getChatModels();
    _getChatModelName();
    selectedModel = chatModels.first;
    getAllChat();
  }

  Future getAllChat() async {
    getChatLoading.value = true;
    try {
      chatList.value = await chatRepo.getUserChat();
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> Get all chat error: $err');
      }
      DialogHelpers.showErrorMessage(err.toString());
    }
    getChatLoading.value = false;
  }

  Future createChat(String initialMessage, [int? assistantId]) async {
    if (initialMessage.isEmpty) {
      DialogHelpers.showErrorMessage('Message not empty.');
      return;
    }
    createLoading.value = true;
    try {
      var chatModel = await chatRepo.createChat(
        initialMessage,
        selectedModel,
        assistantId,
      );
      createLoading.value = false;
      getAllChat();
      Get.toNamed(AppRoutes.chatRoute(
        id: chatModel.id.toString(),
        message: initialMessage,
        modelId: selectedModel,
        fromCreate: true,
        assistantId: assistantId,
      ));
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> Create chat error: $err');
      }
      DialogHelpers.showErrorMessage(err.toString());
      createLoading.value = false;
    }
  }

  Future deleteChat(int chatId) async {
    try {
      String message = await chatRepo.deleteChat(chatId);
      DialogHelpers.showMessage(message);
      getAllChat();
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> Delete chat error: $err');
      }
      DialogHelpers.showErrorMessage(err.toString());
    }
  }

  Future deleteAllChat() async {
    try {
      for (var element in chatList) {
        await chatRepo.deleteChat(element.id);
      }
      chatList.clear();
      DialogHelpers.showMessage('Delete all chat successfully.');
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> Delete all chat error: $err');
      }
      DialogHelpers.showErrorMessage(err.toString());
    }
  }

  Future _getChatModels() async {
    var charModelStr =
        FirebaseRemoteConfig.instance.getString(AppConfig.chatModelsKey);
    chatModels = charModelStr.split(';').map((e) => e.trim()).toList();
  }

  Future _getChatModelName() async {
    var charModelStr =
        FirebaseRemoteConfig.instance.getString(AppConfig.chatModelNameKey);
    chatModelName = charModelStr.split(';').map((e) => e.trim()).toList();
  }
}
