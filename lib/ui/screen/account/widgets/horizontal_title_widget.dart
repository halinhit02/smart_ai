import 'package:flutter/material.dart';

import '../../../../utils/constants/dimensions.dart';

class HorizontalTitleWidget extends StatelessWidget {
  const HorizontalTitleWidget({
    super.key,
    required this.title,
    this.titleStyle,
    this.padding,
  });

  final String title;
  final TextStyle? titleStyle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeSmall,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: titleStyle ??
                Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeDefault,
          ),
          Expanded(
            child: Divider(
              thickness: 1,
              color: Colors.grey.shade200,
            ),
          ),
        ],
      ),
    );
  }
}
