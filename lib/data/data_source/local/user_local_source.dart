import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai/model/user_model.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';

class UserLocalSource {
  SharedPreferences sharedPrefs;

  UserLocalSource({required this.sharedPrefs});

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
