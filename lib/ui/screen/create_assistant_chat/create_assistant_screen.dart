import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/assistant_controller.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/message_field_widget.dart';
import 'package:smart_ai/utils/constants/app_constants.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

import '../../../controller/chat_controller.dart';

class CreateAssistantScreen extends StatelessWidget {
  const CreateAssistantScreen({
    super.key,
    required this.title,
    required this.index,
  });

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    var chatController = Get.find<ChatController>();
    var assistantController = Get.find<AssistantController>();
    var messageController = TextEditingController();
    var somethingLikes = AppConstants.somethingLikes[index.toString()] ?? [];
    var assistantModel = assistantController.assistantList[index];
    chatController.selectedModel = assistantModel.model;
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
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
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
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
                          separatorBuilder: (context, index) =>
                          const SizedBox(
                            height: Dimensions.radiusSizeDefault,
                          ),
                          itemCount: somethingLikes.length,
                          itemBuilder: (itemCtx, index) =>
                              InkWell(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSizeLarge,
                                ),
                                onTap: () {
                                  chatController
                                      .createChat(somethingLikes[index])
                                      .then((value) =>
                                      messageController.clear());
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
                                    style: Theme
                                        .of(context)
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
                    () =>
                    MessageFieldWidget(
                        controller: messageController,
                        loading: chatController.createLoading.value,
                        onTap: () {
                          chatController
                              .createChat(messageController.text)
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
