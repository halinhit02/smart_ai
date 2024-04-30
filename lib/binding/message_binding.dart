import 'package:get/get.dart';
import 'package:smart_ai/controller/message_controller.dart';
import 'package:smart_ai/data/data_source/remote/message_remote_source.dart';
import 'package:smart_ai/data/repository/message_repo.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageRemoteSource(
      sharedPrefs: Get.find(),
    ));
    Get.lazyPut(() => MessageRepo(
          gptRepo: Get.find(),
          geminiRepo: Get.find(),
          messageRemoteSource: Get.find(),
        ));

    Get.put(MessageController(
      messageRepo: Get.find(),
    ));
  }
}
