import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_ai/model/message_model.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';

import '../../model/message_create_model.dart';
import '../../utils/constants/dimensions.dart';
import '../../utils/constants/images.dart';
import 'custom_image.dart';

class CustomLeftMessage extends StatelessWidget {
  const CustomLeftMessage({
    super.key,
    this.messageModel,
    this.messageCreatedModel,
  });

  final MessageModel? messageModel;
  final MessageCreateModel? messageCreatedModel;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle),
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: const CustomImage(
              path: Images.intelligence,
              size: 18,
              color: Colors.white,
            ),
          ),
          Flexible(
            child: messageModel == null && messageCreatedModel == null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radiusSizeDefault),
                        bottomLeft:
                            Radius.circular(Dimensions.radiusSizeDefault),
                        bottomRight:
                            Radius.circular(Dimensions.radiusSizeDefault),
                      ),
                      color: Colors.grey.shade100,
                    ),
                    margin: const EdgeInsets.only(
                      left: Dimensions.paddingSizeSmall,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall,
                    ),
                    child: Lottie.asset(
                      Images.generating,
                      width: 48,
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radiusSizeDefault),
                        bottomLeft:
                            Radius.circular(Dimensions.radiusSizeDefault),
                        bottomRight:
                            Radius.circular(Dimensions.radiusSizeDefault),
                      ),
                      color: Colors.grey.shade100,
                    ),
                    padding: const EdgeInsets.only(
                      left: Dimensions.paddingSizeDefault,
                      right: Dimensions.paddingSizeSmall,
                    ),
                    margin: const EdgeInsets.only(
                      left: Dimensions.paddingSizeSmall,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                        Markdown(
                          data: messageModel?.content ??
                              messageCreatedModel?.content ??
                              '',
                          shrinkWrap: true,
                          selectable: true,
                          softLineBreak: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeExtraSmall,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () => FlutterClipboard.copy(
                                        messageModel?.content ?? '')
                                    .then((value) => DialogHelpers.showMessage('The content is copied.')),
                                icon: const Icon(
                                  CupertinoIcons.doc_on_doc,
                                  size: 16,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final box =
                                      context.findRenderObject() as RenderBox?;
                                  await Share.share(
                                    messageModel?.content ?? '',
                                    sharePositionOrigin:
                                        box!.localToGlobal(Offset.zero) &
                                            box.size,
                                  );
                                },
                                icon: const Icon(
                                  Icons.share_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
