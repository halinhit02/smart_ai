import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/dimensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.hintStyle,
    this.textStyle,
    this.fillColor,
    this.borderRadius,
    this.contentPadding,
    this.borderSide = BorderSide.none,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.editable = true,
    this.inputAction = TextInputAction.next,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines = 1,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.enable,
    this.onSuffixPressed,
    this.onPrefixPressed,
    this.onTap,
  });

  final String? hint;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final BorderSide borderSide;
  final EdgeInsets? contentPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int minLines;
  final int? maxLines;
  final TextInputAction inputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool? enable;
  final bool editable;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onSuffixPressed;
  final Function()? onPrefixPressed;
  final Function()? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode _focus = FocusNode();
  bool _isFocus = false;
  bool _isObscureText = false;

  @override
  void initState() {
    super.initState();
    _isObscureText = widget.obscureText;
    if (widget.focusNode != null) {
      _focus = widget.focusNode!;
    }
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    _isFocus = _focus.hasFocus;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon = widget.obscureText
        ? Icon(
            _isObscureText
                ? CupertinoIcons.eye_slash_fill
                : CupertinoIcons.eye_solid,
            size: 18,
          )
        : widget.suffixIcon;
    return TextField(
      style: widget.textStyle ??
          Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
      onTap: widget.onTap,
      focusNode: _focus,
      enabled: widget.enable,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      obscureText: _isObscureText,
      canRequestFocus: widget.editable,
      keyboardType: widget.keyboardType,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon != null
              ? IconButton(
                  icon: widget.prefixIcon!,
                  onPressed: widget.onPrefixPressed,
                )
              : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: suffixIcon,
                  onPressed: widget.obscureText
                      ? () {
                          setState(() {
                            _isObscureText = !_isObscureText;
                          });
                        }
                      : widget.onSuffixPressed,
                )
              : null,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeSmall,
                horizontal: Dimensions.paddingSizeLarge,
              ),
          hintText: widget.hint,
          hintStyle: widget.hintStyle ??
              Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
          fillColor: widget.fillColor ?? Colors.grey.shade100,
          filled: true,
          suffixIconColor: _isFocus
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.shade500,
          prefixIconColor: _isFocus
              ? Theme.of(context).colorScheme.primary
              : widget.enable ?? true
                  ? Colors.grey.shade500
                  : Colors.grey.shade300,
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ??
                BorderRadius.circular(
                  Dimensions.radiusSizeDefault,
                ),
            borderSide: widget.borderSide,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ??
                BorderRadius.circular(
                  Dimensions.radiusSizeDefault,
                ),
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
    );
  }
}
