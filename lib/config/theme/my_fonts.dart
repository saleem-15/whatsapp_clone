import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFonts {
  MyFonts._();

  /// font type for The Whole App
  static TextStyle get getAppFontType => GoogleFonts.openSans();

  // headlines text font
  static TextStyle get headlineTextStyle => getAppFontType.copyWith();

  // body text font
  static TextStyle get bodyTextStyle => getAppFontType.copyWith();

  // button text font
  static TextStyle get buttonTextStyle => getAppFontType;
  static FontWeight get buttonTextFontWeight => FontWeight.w400;

  // app bar text font
  static TextStyle get appBarTextStyle => getAppFontType;

  //-------------------------------- appbar font--------------------------------
  static double get appBarTittleSize => headline2TextSize;
  static FontWeight get appBarTittleWeight => FontWeight.w600;

  ///----------------------------------------------------------------------------

  // body font size
  static double get body1TextSize => 14.sp;
  static double get body2TextSize => 14.sp;
  static double get bodySmallTextSize => 12.sp;

  static double get bodyLarge => 16.sp;
  static double get bodySmall => 10.sp;

  ///-----------------headlines font size--------------------------------
  static double get headline1TextSize => 26.sp;
  static double get headline2TextSize => 22.sp;
  static double get headline3TextSize => 16.sp;

  static FontWeight get headline1TextWeight => FontWeight.bold;
  static FontWeight get headline2TextWeight => FontWeight.w700;
  static FontWeight get headline3TextWeight => FontWeight.w700;

  ///----------------------------------------------------------------------------

  //button font size
  static double get buttonTextSize => 14.sp;

  //caption font size
  static double get captionTextSize => body1TextSize;
}
