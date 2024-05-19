import 'package:flutter/material.dart';
import 'package:smart_ai/ui/widgets/custom_image.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/constants/my_icons.dart';

class DescriptionItem extends StatelessWidget {
  const DescriptionItem({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomImage(
          path: MyIcons.tickSquare,
          size: 24,
        ),
        const SizedBox(
          width: Dimensions.paddingSizeDefault,
        ),
        Text(
          description,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade800,
              ),
        ),
      ],
    );
  }
}
