import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai/controller/auth_controller.dart';
import 'package:smart_ai/data/data_source/local/auth_local_source.dart';
import 'package:smart_ai/data/data_source/local/user_local_source.dart';
import 'package:smart_ai/data/data_source/remote/auth_remote_source.dart';
import 'package:smart_ai/data/data_source/remote/user_remote_source.dart';
import 'package:smart_ai/data/repository/auth_repo.dart';
import 'package:smart_ai/data/repository/user_repo.dart';

class AppBinding extends Bindings {
  SharedPreferences prefs;

  AppBinding({required this.prefs});

  @override
  void dependencies() {
    Get.lazyPut(() => prefs);

    // Auth
    Get.lazyPut(() => AuthLocalSource(
          sharedPrefs: Get.find(),
        ));
    Get.lazyPut(() => AuthRemoteSource(
          sharedPrefs: Get.find(),
        ));
    Get.lazyPut(() => AuthRepo(
          authLocalSource: Get.find(),
          authRemoteSource: Get.find(),
        ));

    // User
    Get.lazyPut(() => UserRemoteSource(
          sharedPrefs: Get.find(),
        ));
    Get.lazyPut(() => UserLocalSource(
          sharedPrefs: Get.find(),
        ));
    Get.lazyPut(() => UserRepo(
          userRemoteSource: Get.find(),
          userLocalSource: Get.find(),
        ));

    Get.put(
      AuthController(
        authRepo: Get.find(),
        userRepo: Get.find(),
      ),
    );
  }
}
