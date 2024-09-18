import 'package:flutter/material.dart';

class ColorTheme {
  static Color primaryColor = const Color(0XFF1F93EE);
  static Color textColor = const Color(0XFF272727);
  static Color lightGrey = const Color(0XFFF0F0F0);
  static Color hintColor = const Color(0xFFA1A1A1);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: ColorTheme.primaryColor,
      colorScheme: ColorScheme.light(primary: ColorTheme.primaryColor),
      fontFamily: "Roboto",
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        displayMedium: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w400,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        displaySmall: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w400,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w400,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
        labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: ColorTheme.textColor,
            overflow: TextOverflow.ellipsis),
      ));
}
