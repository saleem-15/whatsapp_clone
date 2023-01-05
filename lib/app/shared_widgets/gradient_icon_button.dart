// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:whatsapp_clone/app/shared_widgets/gradient_icon.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';

class GradientIconButton extends StatelessWidget {
  const GradientIconButton({
    Key? key,
    required this.icon,
    this.iconSize,
    this.backgroundSize,
    this.backgroundColor,
    this.gradientType,
    required this.onPressed,
  }) : super(key: key);

  ///icon related Atrribuetes
  final IconData icon;
  final double? iconSize;
  final GradientType? gradientType;

  ///background related Attributes
  final double? backgroundSize;
  final Color? backgroundColor;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: GradientIcon.iconBackgroundBorderRadius,
      onTap: onPressed,
      child: GradientIcon(
        icon: icon,
        backgroundSize: backgroundSize,
        iconSize: iconSize,
        hasBackground: backgroundColor != null,
        backgroundColor: backgroundColor,
        gradientType: gradientType,
      ),
    );

    //  return SizedBox.square(
    //   dimension: size ?? 35.sp,
    //   child: FittedBox(
    //     child: InkWell(
    //       highlightColor: Colors.transparent,
    //       borderRadius: borderRadius,
    //       onTap: onPressed,
    //       child: SizedBox.square(
    //         dimension: 40.sp,
    //         child: GradientIcon(
    //           icon: icon,
    //           size: size ?? 23.sp,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
