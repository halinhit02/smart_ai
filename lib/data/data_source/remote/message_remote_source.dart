import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai/model/api_response_model.dart';
import 'package:smart_ai/model/message_create_model.dart';
import 'package:smart_ai/model/message_model.dart';

import '../../../utils/constants/app_config.dart';
import '../../../utils/constants/app_constants.dart';

class MessageRemoteSource extends GetConnect {
  SharedPreferences sharedPrefs;

  MessageRemoteSource({required this.sharedPrefs}) {
    httpClient.baseUrl = FirebaseRemoteConfig.instance.getString(AppConfig.baseUrlKey);
    httpClient.addRequestModifier<Object?>((request) => request
      ..headers.addAll({
        'Authorization':
            sharedPrefs.getString(AppConstants.accessTokenKey) ?? '',
      }));
  }

  Future<ApiResponseModel<MessageModel>> createMessage(
      MessageCreateModel messageCreateModel) async {
    var response =
        await post(AppConfig.messageEndpoint, messageCreateModel.toJson());
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<MessageModel>.fromJson(
          body, (data) => MessageModel.fromJson(data));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }

  Future<ApiResponseModel<List<MessageModel>>> getAllMessages(
      int chatId) async {
    var response = await get('${AppConfig.messageEndpoint}?chatId=$chatId');
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<List<MessageModel>>.fromJson(
          body,
          (data) => List<MessageModel>.from(
              data.map((value) => MessageModel.fromJson(value))));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }
}
