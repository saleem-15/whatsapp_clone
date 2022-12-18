// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class MyColors {
  static const Color MyBlack = Color(0xff09101D);

  static const Color Green = Color(0xff10C17D);
  static Color LightGreen = Green.withOpacity(.1);

  static const Color red = Color(0xffFF1843);
  static Color LightRed = red.withOpacity(.1);

  static const Color LightGrey = Color(0xff545D69);

  //msg card color
  static const Color cc = Color(0xfff4f6f9);

  static const Gradient myGradient = LinearGradient(
    colors: [
      Color(0xff01ef93),
      Color(0xff0fc57f),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
