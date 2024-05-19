import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/ads_controller.dart';
import 'package:smart_ai/controller/assistant_controller.dart';
import 'package:smart_ai/controller/message_controller.dart';
import 'package:smart_ai/model/assistant_model.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/ui/widgets/custom_left_message.dart';

import 'package:smart_ai/ui/widgets/custom_right_message.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

import '../../widgets/message_field_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    this.id,
    required this.modelId,
    required this.title,
    this.fromCreate = true,
    this.assistantId,
  });

  final String? id;
  final String modelId;
  final String title;
  final bool fromCreate;
  final String? assistantId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var messageController = Get.find<MessageController>();
  var contentController = TextEditingController();
  var scrollController = ScrollController();
  late int chatId;
  AssistantModel? assistantModel;
  String? systemContent;

  @override
  void initState() {
    super.initState();
    chatId = int.tryParse(widget.id ?? '') ?? -1;
    if (widget.assistantId != null && widget.assistantId!.isNotEmpty) {
      assistantModel = Get.find<AssistantController>()
          .assistantList
          .firstWhereOrNull(
              (element) => element.id.toString() == widget.assistantId);
      if (assistantModel != null) {
        systemContent =
            'You are a helpful assistant about ${assistantModel?.title}, designed to ${assistantModel?.description}.';
      }
    }
    if (widget.fromCreate) {
      if (chatId != -1) {
        messageController.createMessage(widget.modelId, widget.title, chatId,
            instruction: systemContent);
      }
    } else {
      messageController.getAllMessages(chatId);
    }
  }

  void _scrollToEndList() {
    try {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Chat screen, scroll to end list: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
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
      body: chatId == -1
          ? const Center(
              child: Text('Chat not existed.'),
            )
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Obx(() {
                          SchedulerBinding.instance.addPostFrameCallback(
                              (timeStamp) => _scrollToEndList());
                          if (!widget.fromCreate &&
                              messageController.messageList.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                              itemCount:
                                  messageController.messageList.length + 1,
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                if (index ==
                                    messageController.messageList.length) {
                                  return Obx(() {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback(
                                            (timeStamp) => _scrollToEndList());
                                    return messageController.generating.isTrue
                                        ? CustomLeftMessage(
                                            messageCreatedModel:
                                                messageController
                                                    .latestMessage.value,
                                          )
                                        : const SizedBox();
                                  });
                                }
                                return messageController
                                            .messageList[index].typeMessage !=
                                        'user'
                                    ? CustomLeftMessage(
                                        messageModel: messageController
                                            .messageList[index],
                                      )
                                    : CustomRightMessage(
                                        messageModel: messageController
                                            .messageList[index],
                                      );
                              });
                        }),
                        Obx(
                          () => messageController.generating.isTrue
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.paddingSizeLarge,
                                    ),
                                    child: CustomButton(
                                      text: 'Stop generating...',
                                      color: Colors.grey.shade50,
                                      mainAxisSize: MainAxisSize.min,
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radiusSizeDefault,
                                      ),
                                      elevation: 1,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeDefault,
                                        vertical: Dimensions.paddingSizeSmall,
                                      ),
                                      leading: Icon(
                                        CupertinoIcons.square_fill,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      leadingPadding: const EdgeInsets.only(
                                        right: Dimensions.paddingSizeSmall,
                                      ),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.grey.shade800,
                                          ),
                                      onTap: () =>
                                          messageController.cancelGenerating(),
                                    ),
                                  ))
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeLarge,
                    ),
                    child: MessageFieldWidget(
                      controller: contentController,
                      onTap: () {
                        bool forceShowAds =
                            widget.modelId.toLowerCase().contains('gpt-4');
                        Get.find<AdsController>().showInterstitialAd(
                          forceShow: forceShowAds,
                        );
                        messageController
                            .createMessage(
                              widget.modelId,
                              contentController.text,
                              chatId,
                              instruction: systemContent,
                            )
                            .then((value) => _scrollToEndList());
                        contentController.text = '';
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
