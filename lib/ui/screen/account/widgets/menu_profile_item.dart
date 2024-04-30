import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/dimensions.dart';
import '../../../../utils/constants/my_icons.dart';
import '../../../widgets/custom_image.dart';

class MenuProfileItem extends StatelessWidget {
  const MenuProfileItem({
    super.key,
    required this.iconPath,
    required this.title,
    this.titleStyle,
    this.padding,
    this.route,
    this.onTap,
  });

  final String iconPath;
  final String title;
  final EdgeInsets? padding;
  final TextStyle? titleStyle;
  final String? route;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Get.toNamed(route!);
        }
        onTap?.call();
      },
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeSmall + 2,
        ),
        child: Row(
          children: [
            CustomImage(
              path: iconPath,
              size: 24,
            ),
            const SizedBox(
              width: Dimensions.paddingSizeLarge,
            ),
            Expanded(
              child: Text(
                title,
                style: titleStyle ??
                    Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
              ),
            ),
            const SizedBox(
              width: Dimensions.paddingSizeDefault,
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
