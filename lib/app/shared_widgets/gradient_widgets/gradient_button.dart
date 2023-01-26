// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../../../config/theme/colors.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isWaitingForResponse,
    required this.isButtonDisable,
  });

  final String text;
  final Function() onPressed;
  final RxBool isWaitingForResponse;
  final RxBool isButtonDisable;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onPressed: isWaitingForResponse.isTrue || isButtonDisable.isTrue ? null : onPressed,
        style: MyStyles.getElevatedButtonTheme().style!.copyWith(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: isWaitingForResponse.isTrue || isButtonDisable.isTrue ? null : MyColors.greenGradient,
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: MyStyles.getTextTheme().bodyText2!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientFloatingActionButton extends StatelessWidget {
  const GradientFloatingActionButton({
    Key? key,
    this.onPressed,
    this.child,
  }) : super(key: key);

  final Function()? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Ink(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: onPressed == null ? Colors.white60 : null,

          /// if there is not a function then dont display the gradien
          /// (to achieve the disabled button effect)
          gradient: onPressed == null ? null : MyColors.greenGradient,
        ),
        child: child,
      ),
    );
  }
}
