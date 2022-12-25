// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:whatsapp_clone/app/shared_widgets/gradient_icon.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';

class GradientIconButton extends StatelessWidget {
  const GradientIconButton({
    Key? key,
    required this.icon,
    this.size,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final double? size;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10.r);

    return SizedBox.square(
      dimension: 35.sp,
      child: FittedBox(
        child: InkWell(
          
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: SizedBox.square(
            dimension: 40.sp,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: MyColors.LightGreen,
                borderRadius: borderRadius,
              ),
              child: GradientIcon(
                icon: icon,
                size: size ?? 23.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
