import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.path,
    this.isFilePath = false,
    this.isOval = false,
    this.boxFit = BoxFit.cover,
    this.size,
    this.width,
    this.height,
    this.color,
    this.padding,
    this.blendMode = BlendMode.srcIn,
    this.borderRadius,
    this.boxBorder,
    this.boxShape = BoxShape.rectangle,
    this.background,
    this.alignment = Alignment.center,
  });

  final String path;
  final bool isFilePath;
  final bool isOval;
  final BoxFit boxFit;
  final double? size;
  final double? width;
  final double? height;
  final Color? color;
  final BlendMode blendMode;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final BoxBorder? boxBorder;
  final BoxShape boxShape;
  final Color? background;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: boxBorder,
        shape: boxShape,
        color: background,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isOval ? 100 : 0),
        child: path.isURL
            ? CachedNetworkImage(
                imageUrl: path,
                fit: boxFit,
                width: width ?? size,
                height: height ?? size,
                color: color,
                colorBlendMode: blendMode,
                alignment: alignment,
                progressIndicatorBuilder: (context, url, _) => const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeSmall,
                    ),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : path.endsWith('.svg')
                ? SvgPicture.asset(
                    path,
                    fit: boxFit,
                    width: width ?? size,
                    height: height ?? size,
                    alignment: alignment,
                    colorFilter: color != null
                        ? ColorFilter.mode(color!, blendMode)
                        : null,
                  )
                : isFilePath
                    ? Image.file(
                        File(path),
                        fit: boxFit,
                        width: width ?? size,
                        alignment: alignment,
                        height: height ?? size,
                        colorBlendMode: blendMode,
                        color: color,
                      )
                    : Image.asset(
                        path,
                        fit: boxFit,
                        width: width ?? size,
                        alignment: alignment,
                        height: height ?? size,
                        colorBlendMode: blendMode,
                        color: color,
                      ),
      ),
    );
  }
}
