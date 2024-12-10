import 'package:festit_invited/themes/app_colors.dart';
import 'package:festit_invited/themes/app_styles.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final String title;
  final double? width;
  final double verticalPadding;
  final double horizontalPadding;
  final TextAlign? textAlign;
  final Function()? onTap;
  final Color? color;

  const SaveButton({
    super.key,
    required this.title,
    this.width,
    this.verticalPadding = 8,
    this.horizontalPadding = 30,
    this.textAlign,
    this.onTap,
    this.color = AppColors.purple,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Text(
          title,
          textAlign: textAlign,
          style: AppStyles.textStyleLabel.copyWith(
            color: AppColors.background,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
