import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai/model/chat_model.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';

import '../../../model/api_response_model.dart';
import '../../../utils/constants/app_config.dart';

class ChatRemoteSource extends GetConnect {
  SharedPreferences sharedPrefs;

  ChatRemoteSource({required this.sharedPrefs}) {
    httpClient.baseUrl = AppConfig.baseUrl;
    httpClient.addRequestModifier<Object?>((request) => request
      ..headers.addAll({
        'Authorization':
            sharedPrefs.getString(AppConstants.accessTokenKey) ?? '',
      }));
  }

  Future<ApiResponseModel<ChatModel>> createChat(
      String title, String model) async {
    var response = await post(AppConfig.chatEndpoint, {
      "title": title,
      "model": model,
    });
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<ChatModel>.fromJson(
          body, (data) => ChatModel.fromJson(data));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }

  Future<ApiResponseModel<List<ChatModel>>> getUserChat() async {
    var response = await get(AppConfig.chatEndpoint);
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<List<ChatModel>>.fromJson(
          body,
          (data) => List<ChatModel>.from(
              data.map((value) => ChatModel.fromJson(value))));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }

  Future<ApiResponseModel> deleteChat(int chatId) async {
    var response = await delete('${AppConfig.chatEndpoint}/$chatId');
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel.fromJson(body);
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }
}
