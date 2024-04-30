import 'package:get/get.dart';
import 'package:smart_ai/controller/assistant_controller.dart';
import 'package:smart_ai/controller/chat_controller.dart';
import 'package:smart_ai/controller/image_controller.dart';
import 'package:smart_ai/data/data_source/remote/assistant_remote_source.dart';
import 'package:smart_ai/data/data_source/remote/chat_remote_source.dart';
import 'package:smart_ai/data/data_source/remote/image_remote_source.dart';
import 'package:smart_ai/data/repository/assistant_repo.dart';
import 'package:smart_ai/data/repository/chat_repo.dart';
import 'package:smart_ai/data/repository/gemini_repo.dart';
import 'package:smart_ai/data/repository/gpt_repo.dart';
import 'package:smart_ai/data/repository/image_repo.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GPTRepo(), fenix: true);
    Get.lazyPut(() => GeminiRepo(), fenix: true);
    Get.lazyPut(() => ChatRemoteSource(
          sharedPrefs: Get.find(),
        ));
    Get.lazyPut(() => ImageRemoteSource(
          sharedPrefs: Get.find(),
        ));
    Get.lazyPut(() => AssistantRemoteSource(
          sharedPrefs: Get.find(),
        ));
    Get.lazyPut(() => ImageRepo(
          imageRemoteSource: Get.find(),
        ));

    Get.lazyPut(() => ChatRepo(
          chatRemoteSource: Get.find(),
        ));

    Get.lazyPut(() => AssistantRepo(
          assistantRemoteSource: Get.find(),
        ));

    Get.put(ChatController(
      chatRepo: Get.find(),
    ));

    Get.put(ImageController(
      gptRepo: Get.find(),
      imageRepo: Get.find(),
    ));
    Get.put(AssistantController(
      assistantRepo: Get.find(),
    ));
  }
}
