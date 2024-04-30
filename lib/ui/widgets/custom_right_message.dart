import 'package:flutter/material.dart';
import 'package:smart_ai/model/message_model.dart';

import '../../utils/constants/dimensions.dart';

class CustomRightMessage extends StatelessWidget {
  const CustomRightMessage({
    super.key,
    required this.messageModel,
  });

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeSmall,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeLarge,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radiusSizeDefault),
                  bottomLeft: Radius.circular(Dimensions.radiusSizeDefault),
                  bottomRight: Radius.circular(Dimensions.radiusSizeDefault),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              margin: const EdgeInsets.only(
                left: Dimensions.paddingSizeSmall,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeSmall,
              ),
              child: Text(
                messageModel.content,
                softWrap: true,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
