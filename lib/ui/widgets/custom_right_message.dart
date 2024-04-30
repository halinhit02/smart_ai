import 'package:flutter/material.dart';

import '../../utils/constants/dimensions.dart';

class CustomRightMessage extends StatelessWidget {
  const CustomRightMessage({super.key});

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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusSizeDefault),
                bottomLeft: Radius.circular(Dimensions.radiusSizeDefault),
                bottomRight: Radius.circular(Dimensions.radiusSizeDefault),
              ),
              color: Colors.grey.shade100,
            ),
            margin: const EdgeInsets.only(
              left: Dimensions.paddingSizeSmall,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeSmall,
            ),
            child: Text(
              'Hello, how are you?\nHello, how are you?\nHello, how are you?',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
