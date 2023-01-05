// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../../config/theme/colors.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isWaitingForResponse,
    required this.isButtonDisable,
  }) : super(key: key);

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
