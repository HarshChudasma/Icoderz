import 'package:flutter/material.dart';
import 'package:icoderz/styles/app_colors.dart';

class AppThemes{

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFFf5f5f5),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: AppColors.primaryColor,
    hoverColor: Colors.transparent,
    iconTheme: const IconThemeData(
      color: AppColors.textColor,
    ),
    textSelectionTheme:
    const TextSelectionThemeData(selectionHandleColor: Colors.transparent),
    focusColor: Colors.transparent,
    colorScheme: const ColorScheme.light(
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.blackColor,
      primary: AppColors.primaryColor,
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(fontSize: 20, color: AppColors.textColor),
      labelSmall: TextStyle(fontSize: 12, color: AppColors.textColor),
      labelMedium: TextStyle(fontSize: 16, color: AppColors.textColor),
    )
  );

}