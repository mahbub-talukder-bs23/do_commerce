import 'package:flutter/material.dart';

import 'colors.dart';

class AppBarThemeClass {
  static final appLightTheme = AppBarTheme(
    backgroundColor: AppLightColors.primary,
    surfaceTintColor: AppLightColors.primary,
    foregroundColor: AppLightColors.surface,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: AppLightColors.textColor),
    titleTextStyle: const TextStyle(
      fontFamily: 'Montserrat',
      color: AppLightColors.textColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

  static final appDarkTheme = AppBarTheme(
    backgroundColor: AppDarkColors.primary,
    surfaceTintColor: AppDarkColors.primary,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: AppDarkColors.textColor),
    titleTextStyle: const TextStyle(
      fontFamily: 'Montserrat',
      color: AppDarkColors.textColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}
