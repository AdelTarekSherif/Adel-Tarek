import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';
import 'app.colors.dart';

class AppTheme {
  String fontFamily;

  AppTheme(this.fontFamily);

  ThemeData lightModeTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      titleSpacing: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    primaryColorDark: const Color(0xFF1A1919),
    canvasColor: const Color(0xFFFFFFFF),
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    disabledColor: Colors.white,
    textTheme: AppTheme.lightTextTheme,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    fontFamily: Root.fontFamily,
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light)
        .copyWith(secondary: const Color(0xFFE4E4E4))
        .copyWith(surface: const Color(0xffFDFDFD)),
  );

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: headline1.copyWith(color: Colors.white),
    displayMedium: headline2.copyWith(color: AppColors.customGreyLevels[100]),
    displaySmall: headline3.copyWith(color: AppColors.customGreyLevels[100]),
    headlineMedium: headline4.copyWith(color: AppColors.customGreyLevels[100]),
    headlineSmall: headline5.copyWith(color: Colors.white),
    titleLarge: headline6.copyWith(color: Colors.white),
    labelLarge: button.copyWith(color: Colors.white),
    bodySmall: caption.copyWith(color: AppColors.customGreyLevels[100]),
    bodyLarge: body.copyWith(color: AppColors.customGreyLevels[100]),
    bodyMedium: bodySmall.copyWith(color: AppColors.customGreyLevels[100]),
    titleMedium: TextStyle(
      color: AppColors.customGreyLevel,
      fontFamily: Root.fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
  );

  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
        color: AppColors.primaryColors[150],
        fontWeight: FontWeight.w500,
        fontSize: 20),
    displayMedium: TextStyle(
        color: AppColors.primaryColors[150],
        fontWeight: FontWeight.w600,
        fontSize: 14),
    displaySmall: TextStyle(
        color: AppColors.primaryColors[300],
        fontWeight: FontWeight.w400,
        fontSize: 14),
    headlineMedium: TextStyle(
        color: AppColors.primaryColors[350],
        fontWeight: FontWeight.w400,
        fontSize: 14),
    headlineSmall: TextStyle(
        color: AppColors.primaryColors[400],
        fontWeight: FontWeight.w400,
        fontSize: 12),
    titleLarge: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
    labelLarge: const TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
    bodySmall: TextStyle(
        color: AppColors.customGreyLevels[200],
        fontWeight: FontWeight.w400,
        fontSize: 13),
    titleMedium: TextStyle(
        color: AppColors.customGreyLevels[450],
        fontWeight: FontWeight.w400,
        fontSize: 10),
    titleSmall: TextStyle(
        color: AppColors.customGreyLevels[500],
        fontWeight: FontWeight.w400,
        fontSize: 9),
  );

  static TextStyle headline1 = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColors[50],
    fontSize: 18,
  );

  static TextStyle headline2 = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColors[50],
    fontSize: 16,
  );

  static TextStyle headline3 = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColors[50],
    fontSize: 12,
  );

  static TextStyle headline4 = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.primaryColors[50],
    fontSize: 14,
  );

  static TextStyle headline5 = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColors[50],
    fontSize: 20,
  );

  static TextStyle headline6 = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColors[200],
    fontSize: 14,
  );

  static TextStyle button = TextStyle(
    fontWeight: FontWeight.w300,
    color: AppColors.primaryColors[50],
    fontSize: 16,
  );

  static TextStyle caption = TextStyle(
    fontWeight: FontWeight.w300,
    color: AppColors.primaryColors[50],
    fontSize: 14,
  );

  static TextStyle input = TextStyle(
    fontWeight: FontWeight.w300,
    color: AppColors.primaryColors[50],
    fontSize: 14,
  );

  static TextStyle body = TextStyle(
    fontWeight: FontWeight.w300,
    color: AppColors.primaryColors[50],
    fontSize: 12,
  );

  static TextStyle bodySmall = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.primaryColors[50],
    fontSize: 12,
  );

  static TextStyle smallText = TextStyle(
    fontWeight: FontWeight.w300,
    color: AppColors.primaryColors[50],
    fontSize: 10,
  );

  static landingTextStyle(context, {bool isBold = false}) => TextStyle(
        fontSize: isBold ? 26 : 24,
        color: Theme.of(context).canvasColor,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      );
}
