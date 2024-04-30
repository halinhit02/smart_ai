import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/dimensions.dart';

class ResultSearchItem extends StatelessWidget {
  const ResultSearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeExtraSmall,
      ),
      padding: const EdgeInsets.only(
        left: Dimensions.paddingSizeLarge,
        right: Dimensions.paddingSizeSmall,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Create short articles',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeSmall,
          ),
          IconButton(
            onPressed: () {},
            alignment: Alignment.centerRight,
            icon: const Icon(
              CupertinoIcons.clear,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
