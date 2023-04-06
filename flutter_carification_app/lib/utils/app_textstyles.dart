import 'package:flutter/material.dart';
import 'package:flutter_carification_app/utils/app_colors.dart';

abstract class AppTextStyles {
  static const String _fontFamily = 'Inter';

  static TextStyle onBoardingTitle({
    double fontSize = 40,
    double height = 44,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.white,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: fontSize,
        height: height / fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle onBoardingDescription({
    double fontSize = 16,
    double height = 26,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.white,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: fontSize,
        height: height / fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle appBar({
    double fontSize = 20,
    double height = 24,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.white,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: fontSize,
        height: height / fontSize,
        fontWeight: fontWeight,
        color: color,
      );
}
