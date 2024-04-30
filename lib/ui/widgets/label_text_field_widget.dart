import 'package:flutter/material.dart';

import '../../utils/constants/dimensions.dart';
import 'custom_text_field.dart';

class LabelTextFieldWidget extends StatelessWidget {
  const LabelTextFieldWidget({
    super.key,
    this.prefixIcon,
    required this.label,
    required this.hint,
    this.initValue = "",
    this.obscureText = false,
    this.isDateSelected = false,
    this.focusNode,
    this.controller,
    this.onTextChanged,
    this.onTap,
  });

  final IconData? prefixIcon;
  final String label;
  final String hint;
  final String initValue;
  final bool obscureText;
  final bool isDateSelected;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String)? onTextChanged;
  final Function()? onTap;

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
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  size: 18,
                )
              : null,
          hint: hint,
          onTap: onTap,
          focusNode: focusNode,
          obscureText: obscureText,
          controller: controller ?? TextEditingController()
            ..text = initValue,
          onChanged: onTextChanged,
        ),
      ],
    );
  }
}
