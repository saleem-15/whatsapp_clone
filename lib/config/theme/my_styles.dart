// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import 'colors.dart';
import 'light_theme_colors.dart';
import 'my_fonts.dart';

class MyStyles {
  MyStyles._();

  static EdgeInsets getHorizintalScreenPadding() => EdgeInsets.symmetric(horizontal: 15.w);

  ///app bar theme
  static AppBarTheme getAppBarTheme() => AppBarTheme(
        /// this is status bar theme (kinda)
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),

        elevation: 0,
        titleTextStyle: getTextTheme().headline3!.copyWith(
              fontSize: MyFonts.appBarTittleSize,
              fontWeight: MyFonts.appBarTittleWeight,
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
          fontWeight: FontWeight.w500,
          fontSize: MyFonts.body2TextSize,
          color: LightThemeColors.bodyTextColor,
        ),

        ///----------------------------- Headings --------------------------------------
        headline1: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline1TextSize,
            fontWeight: MyFonts.headline1TextWeight,
            color: LightThemeColors.headlinesTextColor),
        //
        headline2: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline2TextSize,
            fontWeight: MyFonts.headline2TextWeight,
            color: LightThemeColors.headlinesTextColor),
        //
        headline3: (MyFonts.headlineTextStyle).copyWith(
            fontSize: MyFonts.headline3TextSize,
            fontWeight: MyFonts.headline3TextWeight,
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
          // maximumSize: MaterialStateProperty.all(Size(360.w, 70.sp)),
          fixedSize: MaterialStateProperty.all(Size(340.w, 45.sp)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          ),
          elevation: MaterialStateProperty.all(0),
          textStyle: getElevatedButtonTextStyle(),
          // overlayColor: MaterialStateProperty.all(Colors.transparent),
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

  static OutlinedButtonThemeData getOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(330.w, 45.sp)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            width: 2.sp,
            color: LightThemeColors.primaryColor,
          ),
        ),
      ),
    );
  }

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
        fillColor: Colors.white,
        hintStyle: getTextTheme().caption!.copyWith(
              color: LightThemeColors.headlinesTextColor.withOpacity(.3),
            ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: LightThemeColors.primaryColor, width: 1.5.sp),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: const Color(0xffda1414), width: 1.5.sp),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
      );

  static InputDecoration getInputDecoration() => InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintStyle: getTextTheme().caption!.copyWith(
              color: LightThemeColors.headlinesTextColor.withOpacity(.3),
            ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: LightThemeColors.primaryColor, width: 1.5.sp),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: const Color(0xffda1414), width: 1.5.sp),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
      );

  //*************************** My Custom Styles For a Specific Use Cases  ***********************************

  static InputDecoration getMessageInputDecoration() => MyStyles.getInputDecoration().copyWith(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide.none,
        ),
      );

  ///-------------------- OTP FIELD THEME ------------------------------
  static final OTP_FIELD_BORDER_WIDTH = 1.5.sp;

  static PinTheme get getDefaultPinTheme => PinTheme(
        width: 70.sp,
        height: 53.sp,
        textStyle: getTextTheme().headline2,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffeaeef2),
            width: OTP_FIELD_BORDER_WIDTH,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      );

  static PinTheme get getFocusedPinTheme => getDefaultPinTheme.copyWith(
        decoration: getDefaultPinTheme.decoration!.copyWith(
          border: Border.all(
            color: MyColors.Green,
            width: OTP_FIELD_BORDER_WIDTH,
          ),
        ),
      );
  static PinTheme get getErrorPinTheme => getDefaultPinTheme.copyDecorationWith(
        border: Border.all(
          color: MyColors.red,
          width: OTP_FIELD_BORDER_WIDTH,
        ),
      );

  static PinTheme get getSubmittedPinTheme => getDefaultPinTheme.copyDecorationWith(
        border: Border.all(
          color: MyColors.Green,
          width: OTP_FIELD_BORDER_WIDTH,
        ),
      );

  ///-------------------- OTP FIELD THEME ------------------------------

  static InputDecoration getChatTextFieldStyle() => InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintStyle: getTextTheme().caption!.copyWith(
              color: LightThemeColors.headlinesTextColor.withOpacity(.3),
            ),
        contentPadding: EdgeInsets.symmetric(horizontal: 13.sp, vertical: 0.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: LightThemeColors.lightGrey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: BorderSide(color: LightThemeColors.lightGrey, width: 1.sp),
        ),
      );
}
