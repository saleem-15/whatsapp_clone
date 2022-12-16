import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFonts {
  static TextStyle get getAppFontType => const TextStyle();

  // headlines text font
  static TextStyle get headlineTextStyle => getAppFontType;

  // body text font
  static TextStyle get bodyTextStyle => getAppFontType;

  // button text font
  static TextStyle get buttonTextStyle => getAppFontType;
  static FontWeight get buttonTextFontWeight => FontWeight.w400;

  // app bar text font
  static TextStyle get appBarTextStyle => getAppFontType;

  // appbar font size
  static double get appBarTittleSize => headline2TextSize;

  // body font size
  static double get body1TextSize => 14.sp;
  static double get body2TextSize => 14.sp;
  static double get bodySmallTextSize => 12.sp;

  static double get bodyLarge => 16.sp;
  static double get bodySmall => 10.sp;

  // headlines font size

  static double get headline1TextSize => 30.sp;
  static double get headline2TextSize => 24.sp;
  static double get headline3TextSize => 20.sp;

  //button font size
  static double get buttonTextSize => 14.sp;

  //caption font size
  static double get captionTextSize => body1TextSize;
}
