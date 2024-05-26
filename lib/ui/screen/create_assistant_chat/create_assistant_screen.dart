import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/assistant_controller.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/ui/widgets/message_field_widget.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

import '../../../controller/chat_controller.dart';
import '../../../utils/constants/app_routes.dart';
import '../../../utils/constants/my_icons.dart';

class CreateAssistantScreen extends StatelessWidget {
  const CreateAssistantScreen({
    super.key,
    required this.title,
    required this.assistantId,
  });

  final String title;
  final String assistantId;

  @override
  Widget build(BuildContext context) {
    var chatController = Get.find<ChatController>();
    var assistantController = Get.find<AssistantController>();
    var messageController = TextEditingController();
    var somethingLikes =
        AppConstants.somethingLikes[assistantId] ?? [];
    var assistantModel = assistantController.assistantList
        .firstWhereOrNull((element) => element.id.toString() == assistantId);
    chatController.selectedModel = assistantModel!.model;

    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.upgradePlan),
            icon: const CustomImage(
              path: MyIcons.vip,
            ),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeExtraSmall,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeLarge,
          ),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Type something like:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: Dimensions.radiusSizeDefault,
                          ),
                      itemCount: somethingLikes.length,
                      itemBuilder: (itemCtx, index) => InkWell(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusSizeLarge,
                            ),
                            onTap: () {
                              chatController
                                  .createChat(
                                      somethingLikes[index], assistantModel.id)
                                  .then((value) => messageController.clear());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSizeLarge,
                                  )),
                              padding: const EdgeInsets.all(
                                Dimensions.paddingSizeLarge,
                              ),
                              child: Text(
                                somethingLikes[index],
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                              ),
                            ),
                          ))
                ],
              )),
              const SizedBox(
                height: Dimensions.paddingSizeLarge,
              ),
              Obx(
                () => MessageFieldWidget(
                    controller: messageController,
                    loading: chatController.createLoading.value,
                    onTap: () {
                      chatController
                          .createChat(messageController.text, assistantModel.id)
                          .then((value) => messageController.clear());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
