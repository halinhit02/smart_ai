import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.values,
    required this.hint,
    this.value,
    this.itemStyle,
    this.buttonHeight = kMinInteractiveDimension,
    this.buttonWidth,
    this.buttonPadding,
    this.menuItemPadding,
    this.dropdownColor,
    this.alignment = AlignmentDirectional.centerEnd,
    this.onChanged,
  });

  final List<String> items;
  final List<T> values;
  final String hint;
  final T? value;
  final TextStyle? itemStyle;
  final double buttonHeight;
  final double? buttonWidth;
  final EdgeInsets? buttonPadding;
  final EdgeInsets? menuItemPadding;
  final Color? dropdownColor;
  final AlignmentGeometry alignment;
  final Function(T?)? onChanged;

  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  late T selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      selectedValue = widget.value as T;
    } else {
      selectedValue = widget.values.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        items: List.generate(
          widget.items.length,
          (index) => DropdownMenuItem<T>(
            value: widget.values[index],
            child: Text(
              widget.items[index].toString(),
              overflow: TextOverflow.ellipsis,
              style: widget.itemStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ).toList(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
        hint: Text(
          widget.hint,
          overflow: TextOverflow.ellipsis,
        ),
        value: selectedValue,
        menuItemStyleData: MenuItemStyleData(
          padding: widget.menuItemPadding,
        ),
        buttonStyleData: ButtonStyleData(
            height: widget.buttonHeight,
            width: widget.buttonWidth,
            padding: widget.buttonPadding ??
                const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall,
                ),
            elevation: 0,
            decoration: BoxDecoration(
              color: widget.dropdownColor,
              borderRadius: BorderRadius.circular(
                Dimensions.radiusSizeDefault,
              ),
            )),
        alignment: widget.alignment,
        onChanged: (value) {
          if (value != null) {
            selectedValue = value;
            widget.onChanged?.call(value);
            setState(() {});
          }
        },
      ),
    );
  }
}
