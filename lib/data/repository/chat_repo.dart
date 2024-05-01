import 'package:smart_ai/data/data_source/remote/chat_remote_source.dart';
import 'package:smart_ai/model/chat_model.dart';

class ChatRepo {
  ChatRemoteSource chatRemoteSource;

  ChatRepo({required this.chatRemoteSource});

  Future<ChatModel> createChat(String title, String model,
      [int? assistantId]) async {
    var chatModelResponse =
        await chatRemoteSource.createChat(title, model, assistantId);
    if (chatModelResponse.success && chatModelResponse.data != null) {
      return chatModelResponse.data!;
    } else {
      return Future.error(chatModelResponse.message);
    }
  }

  Future<List<ChatModel>> getUserChat() async {
    var userChatResponse = await chatRemoteSource.getUserChat();
    if (userChatResponse.success && userChatResponse.data != null) {
      return userChatResponse.data!;
    } else {
      return Future.error(userChatResponse.message);
    }
  }

  Future<String> deleteChat(int id) async {
    var userChatResponse = await chatRemoteSource.deleteChat(id);
    if (userChatResponse.success) {
      return userChatResponse.message;
    } else {
      return Future.error(userChatResponse.message);
    }
  }
}
