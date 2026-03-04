import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.height,
    this.fontWeight,
    this.fontStyle,
    this.color,
    this.decorationColor,
    this.maxLines,
    this.softWrap,
    this.textAlign,
    this.textDirection,
    this.style,
    this.overflow,
    this.textDecoration,
  });

  final String text;
  final double? fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? color;
  final Color? decorationColor;
  final int? maxLines;
  final bool? softWrap;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextStyle? style;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      softWrap: softWrap,
      textAlign: textAlign,
      textDirection: textDirection ?? TextDirection.rtl,
      style:
          style ??
          TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? AppColors.grayscale950,
            decoration: textDecoration,
            decorationColor: decorationColor,
            height: height,
          ),
    );
  }
}
