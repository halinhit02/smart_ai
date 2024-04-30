import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:smart_ai/controller/message_controller.dart';
import 'package:smart_ai/ui/widgets/custom_app_bar.dart';
import 'package:smart_ai/ui/widgets/custom_button.dart';
import 'package:smart_ai/ui/widgets/custom_left_message.dart';

import 'package:smart_ai/ui/widgets/custom_right_message.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

import '../../widgets/message_field_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    this.id,
    required this.modelId,
    required this.title,
    this.fromCreate = true,
  });

  final String? id;
  final String modelId;
  final String title;
  final bool fromCreate;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var messageController = Get.find<MessageController>();
  var contentController = TextEditingController();
  var scrollController = ScrollController();
  late int chatId;

  @override
  void initState() {
    super.initState();
    chatId = int.tryParse(widget.id ?? '') ?? -1;
    if (widget.fromCreate) {
      if (chatId != -1) {
        messageController.createMessage(widget.modelId, widget.title, chatId);
      }
    } else {
      messageController.getAllMessages(chatId);
    }
  }

  void _scrollToEndList() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
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
                                      onTap: () => messageController.cancelGenerating(),
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
                        messageController
                            .createMessage(
                                widget.modelId, contentController.text, chatId)
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
