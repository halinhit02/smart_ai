import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smart_ai/data/repository/assistant_repo.dart';
import 'package:smart_ai/model/assistant_model.dart';

import '../utils/helpers/dialog_helpers.dart';

class AssistantController extends GetxController {
  AssistantRepo assistantRepo;

  AssistantController({required this.assistantRepo});

  RxList<AssistantModel> assistantList = <AssistantModel>[].obs;
  RxBool loading = false.obs;

  Future getAll() async {
    try {
      loading.value = true;
      assistantList.value = await assistantRepo.getAll();
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> Get all assistant error: $err');
      }
      DialogHelpers.showErrorMessage(err.toString());
    }
    loading.value = false;
  }

  Future createAssistant(AssistantModel assistantModel) async {
    try {
      loading.value = true;
      await assistantRepo.createAssistant(assistantModel);
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> Create assistant error: $err');
      }
      DialogHelpers.showErrorMessage(err.toString());
    }
    loading.value = false;
  }
}