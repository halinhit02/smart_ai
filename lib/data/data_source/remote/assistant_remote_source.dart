import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai/model/api_response_model.dart';
import 'package:smart_ai/model/assistant_model.dart';

import '../../../utils/constants/app_config.dart';
import '../../../utils/constants/app_constants.dart';

class AssistantRemoteSource extends GetConnect {
  SharedPreferences sharedPrefs;

  AssistantRemoteSource({required this.sharedPrefs}) {
    httpClient.baseUrl = FirebaseRemoteConfig.instance.getString(AppConfig.baseUrlKey);
    httpClient.addRequestModifier<Object?>((request) => request
      ..headers.addAll({
        'Authorization':
            sharedPrefs.getString(AppConstants.accessTokenKey) ?? '',
      }));
  }

  Future<ApiResponseModel<List<AssistantModel>>> getAll() async {
    var response = await get(AppConfig.assistantEndpoint);
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<List<AssistantModel>>.fromJson(
          body,
          (data) => List<AssistantModel>.from(
              data.map((value) => AssistantModel.fromJson(value))));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }

  Future<ApiResponseModel<AssistantModel>> createAssistant(
      AssistantModel assistantModel) async {
    var response =
        await post(AppConfig.assistantEndpoint, assistantModel.toJson());
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<AssistantModel>.fromJson(
          body, (data) => AssistantModel.fromJson(data));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }
}
