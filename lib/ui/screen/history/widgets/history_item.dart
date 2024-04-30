import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_ai/controller/chat_controller.dart';
import 'package:smart_ai/model/chat_model.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

import '../../../../utils/constants/dimensions.dart';
import '../../../../utils/constants/my_icons.dart';
import '../../../widgets/custom_image.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.chatModel,
  });

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeLarge,
        ),
        color: Colors.red,
        child: const CustomImage(
          path: MyIcons.delete,
          color: Colors.white,
        ),
      ),
      key: ValueKey(chatModel),
      confirmDismiss: (direction) async {
        bool value = false;
        await DialogHelpers.showAlertDialog(
            context, 'Delete Chat', "Do you want to delete the chat?",
            onDone: () {
          value = true;
          Get.back();
          Get.find<ChatController>().deleteChat(chatModel.id);
        });
        return value;
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: Dimensions.paddingSizeSmall,
        ),
        padding: const EdgeInsets.only(
          top: Dimensions.radiusSizeDefault,
          bottom: Dimensions.radiusSizeDefault,
          left: Dimensions.paddingSizeLarge,
          right: Dimensions.paddingSizeLarge,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraSmall,
                  ),
                  Text(
                    DateFormat.yMEd().format(chatModel.createdAt),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                  ),
                ],
              ),
            ),
            const CustomImage(
              path: MyIcons.arrowLeft,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
