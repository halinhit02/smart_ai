import 'package:flutter/material.dart';

import '../../utils/constants/dimensions.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    this.value = false,
    this.splashRadius,
    this.borderRadius,
    this.onChanged,
  });

  final bool value;
  final double? splashRadius;
  final BorderRadius? borderRadius;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      splashRadius: splashRadius,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(
          Dimensions.radiusSizeExtraSmall,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
