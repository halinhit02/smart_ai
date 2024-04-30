import 'package:flutter/material.dart';

import '../../utils/constants/dimensions.dart';
import 'custom_text_field.dart';

class LabelTextFieldWidget extends StatelessWidget {
  const LabelTextFieldWidget({
    super.key,
    required this.prefixIcon,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.controller,
  });

  final IconData prefixIcon;
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeSmall,
        ),
        CustomTextField(
          prefixIcon: Icon(
            prefixIcon,
            size: 18,
          ),
          hint: hint,
          obscureText: obscureText,
          controller: controller,
        ),
      ],
    );
  }
}
