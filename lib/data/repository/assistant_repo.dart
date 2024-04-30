import 'package:smart_ai/data/data_source/remote/assistant_remote_source.dart';
import 'package:smart_ai/model/assistant_model.dart';

class AssistantRepo {
  AssistantRemoteSource assistantRemoteSource;

  AssistantRepo({required this.assistantRemoteSource});

  Future<List<AssistantModel>> getAll() async {
    var assistantListResponse = await assistantRemoteSource.getAll();
    if (assistantListResponse.success && assistantListResponse.data != null) {
      return assistantListResponse.data!;
    } else {
      return Future.error(assistantListResponse.message);
    }
  }

  Future<AssistantModel> createAssistant(AssistantModel assistantModel) async {
    var assistantListResponse =
        await assistantRemoteSource.createAssistant(assistantModel);
    if (assistantListResponse.success && assistantListResponse.data != null) {
      return assistantListResponse.data!;
    } else {
      return Future.error(assistantListResponse.message);
    }
  }
}
