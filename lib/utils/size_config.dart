import 'package:flutter/widgets.dart';

const double desktopBreakpoint = 950;
const double tabletBreakpoint = 600;
const double watchBreakpoint = 300;

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;

  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static late double widthMultiplier;
  static late double heightMultiplier;

  static bool isPortrait = true;

  static bool isDesktopPortrait = false;
  static bool isTabletPortrait = false;
  static bool isMobilePortrait = false;
  static bool isWatchPortrait = false;

  static bool isDesktop = false;
  static bool isTablet = false;
  static bool isMobile = true;
  static bool isWatch = false;


  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;

      if (screenWidth <= watchBreakpoint) {
        isWatch = true;
        isWatchPortrait = true;
      } else if (screenWidth > watchBreakpoint &&
          screenWidth <= tabletBreakpoint) {
        isMobile = true;
        isMobilePortrait = true;
      } else if (screenWidth > tabletBreakpoint &&
          screenWidth <= desktopBreakpoint) {
        isTablet = true;
        isTabletPortrait = true;
      } else {
        isDesktop = true;
        isDesktopPortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;

      isDesktopPortrait = false;
      isTabletPortrait = false;
      isMobilePortrait = false;
      isWatchPortrait = false;

      if (screenWidth <= watchBreakpoint) {
        isWatch = true;
      } else if (screenWidth > watchBreakpoint &&
          screenWidth <= tabletBreakpoint) {
        isMobile = true;
      } else if (screenWidth > tabletBreakpoint &&
          screenWidth <= desktopBreakpoint) {
        isTablet = true;
      } else {
        isDesktop = true;
      }
    }

    _blockWidth = screenWidth / 100;
    _blockHeight = screenHeight / 100;

    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

  }
}
