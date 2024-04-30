import 'package:flutter/material.dart';

import '../../../../utils/constants/dimensions.dart';
import '../../../../utils/constants/my_icons.dart';
import '../../../widgets/custom_image.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: Dimensions.paddingSizeSmall,
        left: Dimensions.paddingSizeLarge,
        right: Dimensions.paddingSizeLarge,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(
          Dimensions.radiusSizeDefault,
        ),
      ),
      padding: const EdgeInsets.only(
        top: Dimensions.radiusSizeDefault,
        bottom: Dimensions.radiusSizeDefault,
        left: Dimensions.paddingSizeDefault,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'I weigh 70 kg, I want a diet plan to ...',
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
                  '29 Dec 2023',
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
    );
  }
}
