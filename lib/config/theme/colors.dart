// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

enum GradientType {
  greenGradient,
  RedGradient,
}

Gradient getGradient(GradientType gradientType) {
  switch (gradientType) {
    case GradientType.greenGradient:
      return MyColors.greenGradient;

    case GradientType.RedGradient:
      return MyColors.redGradient;

    default:
      return MyColors.greenGradient;
  }
}

class MyColors {
  MyColors._();
  static const Color MyBlack = Color(0xff09101D);
  static const Color BlackScaffold = Colors.black54;
  static const Color LightBlack = Color(0xff363f48);
  static const Color SnackBarColor = Color(0xff333333);

  static const Color Green = Color(0xff10C17D);
  static const Color MyMessageColor = Color(0xffd1fee5);
  static const Color OtherMessageColor = Color(0xffedf0f5);
  static Color LightGreen = Green.withOpacity(.1);

  static const Color red = Color(0xffFF1843);
  static Color LightRed = red.withOpacity(.1);

  static const Color LightGrey = Color(0xff545D69);

  //msg card color
  static const Color cc = Color(0xfff4f6f9);

  static const Gradient greenGradient = LinearGradient(
    colors: [
      Color(0xff01ef93),
      Color(0xff0fc57f),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Gradient redGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 252, 58, 94),
      red,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
