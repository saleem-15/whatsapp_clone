import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'light_theme_colors.dart';
import 'my_fonts.dart';

class MyStyles {
  ///app bar theme
  static AppBarTheme getAppBarTheme() => AppBarTheme(
        /// this is status bar theme (kinda)
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        elevation: 0,
        titleTextStyle: getTextTheme().headline1!.copyWith(
              fontSize: MyFonts.appBarTittleSize,
              color: LightThemeColors.headlinesTextColor,
            ),
        iconTheme: const IconThemeData(
          color: LightThemeColors.appBarIconsColor,
        ),
        backgroundColor: LightThemeColors.appBarColor,
      );

  ///icons theme
  static IconThemeData getIconTheme() => const IconThemeData(
        color: LightThemeColors.iconColor,
      );

  /// Tab Bar theme
  static TabBarTheme getTabBarTheme() => TabBarTheme(
        unselectedLabelColor: LightThemeColors.captionTextColor,
        labelStyle: getTextTheme().bodyLarge,
        unselectedLabelStyle: getTextTheme().bodyLarge,
        labelColor: LightThemeColors.primaryColor,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: LightThemeColors.primaryColor,
              width: 2.sp,
            ),
          ),
        ),
      );

  ///text theme
  static TextTheme getTextTheme() => TextTheme(
        button: MyFonts.buttonTextStyle.copyWith(fontSize: MyFonts.buttonTextSize),

        ///------------------------------- BodyText --------------------------------------
        bodyText1: (MyFonts.bodyTextStyle).copyWith(
          fontWeight: FontWeight.bold,
          fontSize: MyFonts.body1TextSize,
          color: LightThemeColors.bodyTextColor,
        ),

        bodyText2: (MyFonts.bodyTextStyle).copyWith(
          fontSize: MyFonts.body2TextSize,
          color: LightThemeColors.bodyTextColor,
        ),

        ///----------------------------- Headings --------------------------------------
        headline1: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline1TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        headline2: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline2TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),
        //
        headline3: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline3TextSize,
            fontWeight: FontWeight.bold,
            color: LightThemeColors.headlinesTextColor),

        ///----------------------------------------------------------------------------

        /// light vesion of bodyText (lighter color)
        caption: TextStyle(
          color: LightThemeColors.captionTextColor,
          fontSize: MyFonts.captionTextSize,
        ),
      );

  // elevated button text style
  static MaterialStateProperty<TextStyle?>? getElevatedButtonTextStyle() {
    return MaterialStateProperty.all(
      MyFonts.buttonTextStyle.copyWith(
        fontWeight: MyFonts.buttonTextFontWeight,
        fontSize: MyFonts.buttonTextSize,
        color: LightThemeColors.buttonTextColor,
      ),
    );
  }

  //elevated button theme data
  static ElevatedButtonThemeData getElevatedButtonTheme() => ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.5.r)),
          ),
          elevation: MaterialStateProperty.all(0),
          textStyle: getElevatedButtonTextStyle(),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return LightThemeColors.buttonColor.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return LightThemeColors.buttonDisabledColor;
              }
              return LightThemeColors.buttonColor; // Use the component's default.
            },
          ),
        ),
      );

  static TextButtonThemeData getTextButtonTheme() => TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
      );

// static
  static getRadioButtonTheme() => RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(LightThemeColors.radioColor),
      );

  /// divider theme
  static getDividerTheme() => const DividerThemeData(
        color: LightThemeColors.dividerColor,
        space: 0,
        thickness: .5,
      );

  /// dialog theme
  static getDialogTheme() => DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      );

  /// card theme
  static getCardTheme() => const CardTheme(
        margin: EdgeInsets.zero,
      );

  // bottom sheet theme
  static BottomSheetThemeData getBottomSheetTheme() {
    return BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  static InputDecorationTheme getInputDecorationTheme() => InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
      );
  static InputDecoration getInputDecoration() => InputDecoration(
        filled: true,
        fillColor: LightThemeColors.lightGrey,
        // contentPadding: EdgeInsets.only(left: 15.sp, right: 10.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1.5),
        ),
      );

  //*************************** My Custom Styles For a Specific Use Cases  ***********************************

  static OutlinedButtonThemeData getOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(330.w, 40.sp)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.sp),
          ),
        ),
        side: MaterialStateProperty.all(
          const BorderSide(
            width: 1,
            color: LightThemeColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
