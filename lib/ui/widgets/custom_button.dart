import 'package:flutter/material.dart';

import '../../utils/constants/dimensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.color,
    this.borderRadius,
    this.borderSide = BorderSide.none,
    this.padding,
    this.textColor,
    this.textStyle,
    this.leading,
    this.loading = false,
    this.leadingPadding = EdgeInsets.zero,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.onTap,
  });

  final String text;
  final Color? color;
  final BorderRadius? borderRadius;
  final BorderSide borderSide;
  final EdgeInsets? padding;
  final Color? textColor;
  final TextStyle? textStyle;
  final MainAxisSize mainAxisSize;
  final Widget? leading;
  final bool loading;
  final EdgeInsets leadingPadding;
  final MainAxisAlignment mainAxisAlignment;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: loading ? null : onTap,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      color: loading ? null : color ?? Theme.of(context).colorScheme.primary,
      shape: loading
          ? null
          : RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(100),
              side: borderSide,
            ),
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeDefault - 2,
          ),
      child: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              mainAxisSize: mainAxisSize,
              mainAxisAlignment: mainAxisAlignment,
              children: [
                if (leading != null)
                  Padding(
                    padding: leadingPadding,
                    child: leading!,
                  ),
                Text(
                  text,
                  style: textStyle ??
                      Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColor ?? Colors.white,
                          ),
                ),
              ],
            ),
    );
  }
}
