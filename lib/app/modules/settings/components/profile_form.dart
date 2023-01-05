// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone/app/modules/settings/controllers/profile_screen_controller.dart';

import 'package:whatsapp_clone/config/theme/colors.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldName(context, 'Name'),
          SizedBox(height: 5.sp),
          TextFormField(
            controller: controller.userNameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              LengthLimitingTextInputFormatter(25),
            ],
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
            validator: controller.userNameValidator,
          ),
          SizedBox(
            height: 15.h,
          ),
          _buildFieldName(context, 'About'),
          SizedBox(
            height: 5.sp,
          ),
          TextFormField(
            controller: controller.aboutController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: 'About',
            ),
            validator: controller.aboutValidator,
          ),
          SizedBox(
            height: 15.h,
          ),
          _buildFieldName(context, 'Phone'),
          SizedBox(
            height: 5.sp,
          ),
          TextFormField(
            controller: controller.phoneNumberFieledController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(12),
            ],
            decoration: const InputDecoration(
              hintText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
            ),
            validator: controller.phoneNumberFieldValidator,
          ),
        ],
      ),
    );
  }

  Widget _buildFieldName(BuildContext context, String text) {
    return Row(
      children: [
        SizedBox(
          width: 10.sp,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).hintColor,
              ),
        ),
        Text(
          '*',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: MyColors.red,
              ),
        ),
      ],
    );
  }
}
