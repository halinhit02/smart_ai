import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.textStyle,
    this.centerTitle = true,
    this.actions,
    this.forceMaterialTransparency = false,
    this.leading,
    this.leadingWidth,
    this.titleSpacing,
  });

  final String? title;
  final Widget? titleWidget;
  final TextStyle? textStyle;
  final bool centerTitle;
  final List<Widget>? actions;
  final bool forceMaterialTransparency;
  final Widget? leading;
  final double? leadingWidth;
  final double? titleSpacing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      title: title != null
          ? Text(
              title!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: textStyle ??
                  Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
            )
          : titleWidget,
      centerTitle: centerTitle,
      actions: actions,
      titleSpacing: titleSpacing,
      forceMaterialTransparency: forceMaterialTransparency,
      leading: leading,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
