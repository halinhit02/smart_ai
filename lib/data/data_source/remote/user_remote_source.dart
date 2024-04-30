import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai/model/user_model.dart';

import '../../../model/api_response_model.dart';
import '../../../utils/constants/app_config.dart';
import '../../../utils/constants/app_constants.dart';

class UserRemoteSource extends GetConnect {
  SharedPreferences sharedPrefs;

  UserRemoteSource({required this.sharedPrefs}) {
    httpClient.baseUrl = AppConfig.baseUrl;
    httpClient.addRequestModifier<Object?>((request) => request
      ..headers.addAll({
        'Authorization':
            sharedPrefs.getString(AppConstants.accessTokenKey) ?? '',
      }));
  }

  Future<ApiResponseModel<UserModel>> editUserModel(UserModel userModel) async {
    var response = await put(
        '${AppConfig.userEndpoint}/info', userModel.toJson());
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<UserModel>.fromJson(
          body, (data) => UserModel.fromJson(data));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }
}
