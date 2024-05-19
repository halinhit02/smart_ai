import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';

import '../../../../utils/constants/dimensions.dart';
import '../../../../utils/constants/images.dart';
import '../../../widgets/custom_image.dart';

class UpgradeWidget extends StatelessWidget {
  const UpgradeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.upgradePlan),
      child: Container(
        padding: const EdgeInsets.only(
          top: Dimensions.paddingSizeDefault,
          bottom: Dimensions.paddingSizeDefault,
          left: Dimensions.paddingSizeDefault,
          right: Dimensions.paddingSizeDefault,
        ),
        margin: const EdgeInsets.only(
          top: Dimensions.paddingSizeLarge,
          bottom: Dimensions.paddingSizeSmall,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(
            Dimensions.radiusSizeLarge,
          ),
        ),
        child: Row(
          children: [
            const CustomImage(
              path: Images.starUpgrade,
              size: 64,
            ),
            const SizedBox(
              width: Dimensions.paddingSizeDefault,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upgrade to PRO!',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Enjoy all benefits without restrictions',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade50,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.right_chevron,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
