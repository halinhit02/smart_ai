import 'package:flutter/material.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/ui/widgets/custom_text_field.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

import '../../utils/constants/dimensions.dart';

class MessageFieldWidget extends StatelessWidget {
  const MessageFieldWidget({
    super.key,
    this.controller,
    this.onTap,
    this.loading = false,
    this.focusNode,
    this.onVoiceClicked,
    this.onAddClicked,
  });

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool loading;
  final Function()? onAddClicked;
  final Function()? onVoiceClicked;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        alignment: Alignment.center,
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: const CircularProgressIndicator(),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextField(
            focusNode: focusNode,
            controller: controller,
            maxLines: 5,
            // prefixIcon: const CustomImage(
            //   path: MyIcons.add,
            //   size: 14,
            // ),
            // onSuffixPressed: () {
            //   if (onVoiceClicked != null) {
            //     onVoiceClicked!();
            //   }
            //   showDialog(
            //     context: context,
            //     builder: (context) => const Dialog(
            //       insetPadding: EdgeInsets.zero,
            //       child: SpeechToTechWidget(),
            //     ),
            //   );
            // },
            // suffixIcon: const CustomImage(
            //   path: MyIcons.voice,
            //   size: 20,
            // ),
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
                size: 18,
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
