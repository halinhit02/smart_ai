import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/dimensions.dart';
import '../../utils/constants/images.dart';
import 'custom_image.dart';

class CustomLeftMessage extends StatelessWidget {
  const CustomLeftMessage({super.key});

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
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle),
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: const CustomImage(
              path: Images.intelligence,
              size: 14,
              color: Colors.white,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(Dimensions.radiusSizeDefault),
                bottomLeft: Radius.circular(Dimensions.radiusSizeDefault),
                bottomRight: Radius.circular(Dimensions.radiusSizeDefault),
              ),
              color: Colors.grey.shade100,
            ),
            margin: const EdgeInsets.only(
              left: Dimensions.paddingSizeSmall,
            ),
            padding: const EdgeInsets.only(
              left: Dimensions.paddingSizeDefault,
              right: Dimensions.paddingSizeSmall,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
                Text(
                  'Hello, how are you?\nHello, how are you?\nHello, how are you?',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeExtraSmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.hand_thumbsup,
                        size: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.hand_thumbsdown,
                        size: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.doc_on_doc,
                        size: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share_outlined,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
