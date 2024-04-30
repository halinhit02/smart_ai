import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai/model/api_response_model.dart';
import 'package:smart_ai/model/sign_up_model.dart';
import 'package:smart_ai/model/user_model.dart';
import 'package:smart_ai/utils/constants/app_config.dart';

class AuthRemoteSource extends GetConnect {
  SharedPreferences sharedPrefs;

  AuthRemoteSource({required this.sharedPrefs}) {
    httpClient.baseUrl = AppConfig.baseUrl;
  }

  Future<ApiResponseModel<UserModel>> signUp(SignUpModel signUpModel) async {
    var response = await post(AppConfig.signUpEndpoint, signUpModel.toJson());
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<UserModel>.fromJson(
          body, (data) => UserModel.fromJson(data));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }

  Future<ApiResponseModel<UserModel>> signIn(
      String phone, String password) async {
    var response = await post(AppConfig.signInEndpoint, {
      "phone": phone,
      "password": password,
    });
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<UserModel>.fromJson(
          body, (data) => UserModel.fromJson(data));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }

  Future<ApiResponseModel<UserModel>> forgotPassword(
      String phone, String password) async {
    var response = await post(AppConfig.forgotPasswordEndpoint, {
      "phone": phone,
      "password": password,
    });
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<UserModel>.fromJson(
          body, (data) => UserModel.fromJson(data));
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }

  Future<ApiResponseModel> changePassword(
      String phone, String currentPassword, String newPassword) async {
    var response = await post(AppConfig.changePasswordEndpoint, {
      "phone": phone,
      "password": currentPassword,
      "newPassword": newPassword,
    });
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel.fromJson(body);
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }

  Future<ApiResponseModel<bool>> checkPhoneExisted(String phone) async {
    var response = await post(AppConfig.checkPhoneEndpoint, {
      "phone": phone,
    });
    if (response.body != null) {
      var body = response.body;
      return ApiResponseModel<bool>.fromJson(
          body, (data) => data['existed'] ?? false);
    }
    return Future.error(response.statusText ?? 'Something went wrong.');
  }
}
