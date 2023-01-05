// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../../config/theme/colors.dart';

class GradientGenericButton extends StatelessWidget {
  const GradientGenericButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(13.r);

    return SizedBox.square(
      dimension: 40.sp,
      child: ElevatedButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onPressed: onPressed,
        style: MyStyles.getElevatedButtonTheme().style!.copyWith(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: borderRadius),
              ),
              fixedSize: null,
              minimumSize: null,
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: MyColors.greenGradient,
          ),
          child: Container(
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
