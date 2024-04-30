import 'package:flutter/material.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/ui/widgets/custom_text_field.dart';
import 'package:smart_ai/ui/widgets/speech_to_text_dialog.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

import '../../utils/constants/dimensions.dart';

class MessageFieldWidget extends StatelessWidget {
  const MessageFieldWidget({
    super.key,
    this.onTap,
    this.focusNode,
    this.onVoiceClicked,
    this.onAddClicked,
  });

  final FocusNode? focusNode;
  final Function()? onAddClicked;
  final Function()? onVoiceClicked;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextField(
            focusNode: focusNode,
            maxLines: 5,
            prefixIcon: const CustomImage(
              path: MyIcons.add,
              size: 14,
            ),
            onSuffixPressed: () {
              if (onVoiceClicked != null) {
                onVoiceClicked!();
              }
              showDialog(
                context: context,
                builder: (context) => const Dialog(
                  insetPadding: EdgeInsets.zero,
                  child: SpeechToTechWidget(),
                ),
              );
            },
            suffixIcon: const CustomImage(
              path: MyIcons.voice,
              size: 20,
            ),
            hint: 'Ask me anything...',
            fillColor: Colors.grey.shade100,
          ),
        ),
        const SizedBox(
          width: Dimensions.paddingSizeExtraSmall,
        ),
        IconButton(
            onPressed: onTap,
            icon: Container(
              padding: const EdgeInsets.all(
                Dimensions.paddingSizeDefault,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: const CustomImage(
                path: MyIcons.send,
                size: 20,
                color: Colors.white,
              ),
            ))
      ],
    );
  }
}
