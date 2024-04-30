import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    this.buttonWidth = 72,
    this.buttonPadding,
    this.menuItemPadding,
    this.dropdownColor,
    this.alignment = AlignmentDirectional.center,
    this.onChanged,
  });

  final List<String> items;
  final List<T> values;
  final String hint;
  final T? value;
  final TextStyle? itemStyle;
  final double buttonHeight;
  final double buttonWidth;
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
              style: widget.itemStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ).toList(),
        hint: Text(widget.hint),
        value: selectedValue,
        menuItemStyleData: MenuItemStyleData(
          padding: widget.menuItemPadding,
        ),
        buttonStyleData: ButtonStyleData(
            height: widget.buttonHeight,
            width: widget.buttonWidth,
            padding: widget.buttonPadding,
            elevation: 0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimensions.radiusSizeDefault,
              ),
            )),
        alignment: widget.alignment,
        onChanged: (value) {
          if (value != null) {
            selectedValue = value;
            widget.onChanged?.call(value);
            setState(() {
            });
          }
        },
      ),
    );
  }
}
