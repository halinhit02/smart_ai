import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';

import '../../../model/user_model.dart';

class AuthLocalSource {
  SharedPreferences sharedPrefs;

  AuthLocalSource({required this.sharedPrefs});

  void saveRememberMe(bool isRememberMe) {
    sharedPrefs.setBool(AppConstants.rememberMeKey, isRememberMe);
  }

  bool getRememberMe() {
    return sharedPrefs.getBool(AppConstants.rememberMeKey) ?? false;
  }

  Future savePhoneNumberPassword(String phone, String password) async {
    await sharedPrefs.setString(AppConstants.phoneNumberKey, phone);
    await sharedPrefs.setString(AppConstants.passwordKey, password);
  }

  String getRememberPhone() {
    return sharedPrefs.getString(AppConstants.phoneNumberKey) ?? '';
  }

  String getRememberPassword() {
    return sharedPrefs.getString(AppConstants.passwordKey) ?? '';
  }

  Future saveAccessToken(String accessToken) {
    return sharedPrefs.setString(AppConstants.accessTokenKey, accessToken);
  }

  Future<bool> saveUserLocal(UserModel userModel) async {
    return await sharedPrefs.setString(
        AppConstants.userModelKey, userModel.toRawJson());
  }

  UserModel? getUserLocal() {
    String? userModelStr = sharedPrefs.getString(AppConstants.userModelKey);
    if (userModelStr == null) {
      return null;
    }
    return UserModel.fromRawJson(userModelStr);
  }

  Future<bool> deleteUserLocal() async {
    return await sharedPrefs.remove(AppConstants.userModelKey);
  }
}
