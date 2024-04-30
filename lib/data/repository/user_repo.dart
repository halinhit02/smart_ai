import 'package:smart_ai/data/data_source/local/user_local_source.dart';
import 'package:smart_ai/data/data_source/remote/user_remote_source.dart';
import 'package:smart_ai/model/user_model.dart';

class UserRepo {
  UserLocalSource userLocalSource;
  UserRemoteSource userRemoteSource;

  UserRepo({
    required this.userLocalSource,
    required this.userRemoteSource,
  });

  Future<UserModel> editUser(UserModel userModel) async {
    var userResponse = await userRemoteSource.editUserModel(userModel);
    if (userResponse.success && userResponse.data != null) {
      return userResponse.data!;
    } else {
      return Future.error(userResponse.message);
    }
  }
}
