import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class TextDefault extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final String? fontFamily;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;
  final int? maxLines;

  const TextDefault({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.fontFamily,
    this.decoration,
    this.fontStyle,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontStyle: fontStyle,
        fontFamily: fontFamily ?? 'Montserrat',
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.buttonPrimary,
        fontWeight: fontWeight ?? FontWeight.w600,
        decoration: decoration,
        decorationColor: AppColors.buttonPrimary,
      ),
      textAlign: textAlign ?? TextAlign.center,
      overflow: overflow,
      maxLines: maxLines ?? 1,
    );
  }
}
