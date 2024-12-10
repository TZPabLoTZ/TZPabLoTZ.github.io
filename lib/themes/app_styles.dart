import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  AppStyles._();

  static const textStyleTitle = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );

  static const textStyleContent = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.normal,
  );

  static const textStyleButtonPrimary = TextStyle(
    color: AppColors.buttonPrimary,
    fontWeight: FontWeight.bold,
  );

  static const textStyleButtonSecondary = TextStyle(
    color: AppColors.buttonSecondary,
    fontWeight: FontWeight.bold,
  );

  static const textStyleLabel = TextStyle(
    color: AppColors.primaryLight,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const outlineInputBorderLogin = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.hintLogin,
      width: 0.5,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(0),
    ),
  );

  static const outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.purple,
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const outlineInputBorderConvidados = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.hintLogin,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
  );
}
