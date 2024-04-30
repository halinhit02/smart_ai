import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/constants/dimensions.dart';
import 'custom_image.dart';

class AssistantItem extends StatelessWidget {
  const AssistantItem({
    super.key,
    required this.item,
    this.margin,
  });

  final Map<String, dynamic> item;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Dimensions.paddingSizeLarge,
      ),
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(
            width: 2,
            color: Colors.grey.shade100,
          ),
          borderRadius: BorderRadius.circular(
            Dimensions.radiusSizeLarge,
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
            path: item['icon'],
            color: Colors.white,
            size: 32,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeDefault,
            ),
            borderRadius: BorderRadius.circular(
              Dimensions.radiusSizeDefault,
            ),
            background: HexColor(item['color']),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          Text(
            item['title'] ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),
          Expanded(
            child: Text(
              item['description'] ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
