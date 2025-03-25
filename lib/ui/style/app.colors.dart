import 'package:flutter/material.dart';

class AppColors {
  static const Color kEmptyColor = Color(0XFFF2F2F2);
  static const Color backgroundColor = Color(0XFF1E6A87);

  static const MaterialColor primaryColors = MaterialColor(
    0xFF1E6A87,
    <int, Color>{
      50: Color(0xFF1E6A87),
      100: Color(0xFFBABBC2),
      150: Color(0xFFE4E4E4),
      200: Color(0xFF8B8B8B),
      250: Color(0xFF3F3F3F),
      300: Color(0xFF9D9D9D),
      350: Color(0xFF8A8C8E),
      400: Color(0xFF41464B),
      450: Color(0xFFC4C4C4),
      500: Color(0xFF06070D), // Constant Dark
      550: Color(0xFFEE6767),
      600: Color(0xFFE9EFF4),
      610: Color(0xFFF4F7F9),
      620: Color(0xFF808FA3),
    },
  );

  static const MaterialColor customGreyLevels = MaterialColor(
    0xFF9D9D9D,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
    },
  );

  static const MaterialColor accentLevels = MaterialColor(
    0xFFFEAA2B,
    <int, Color>{
      50: Color(0xFF1A1919),
      100: Color(0xFFED9153),
    },
  );

  static Color scaffoldBackgroundColor = const Color(0xfffcfcfc);

  // Todo: Put the right color later
  static Color primaryColor = const Color(0xFF0149E4);
  static Color textColor = const Color(0xFF1A202C);
  static Color borderColor = const Color(0xFFE9EAEC);
  static Color inActiveButtonColor = const Color(0xFFCCDBFA);

  static Color customGreyLevel = const Color(0xFFF5F5F5);
  static Color customGreyLevelSubtitle1Dark = const Color(0xFF4c4c4c);

  static Color customLightGreenColor = const Color(0xFF4CB087);

  static Color lightGrayColor = const Color(0xFFF5F4F8);
}
