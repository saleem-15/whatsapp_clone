import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:whatsapp_clone/app/modules/auth/controllers/signup_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';

class SignUpForm extends GetView<SignupController> {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          'Sign up for free',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Phone Number',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: 30.sp,
                          ),
                    ),
                    TextSpan(
                      text: '*',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: MyColors.red,
                            fontSize: 30.sp,
                          ),
                    ),
                  ],
                ),
                textScaleFactor: 0.5,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Form(
          key: controller.formKey,
          child: Column(
            children: [
              PhoneNumberField(
                key: const Key('Sign_up_phone_field'),
                textController: controller.phoneNumberFieldController,
                onPhoneNumberChanged: controller.onPhoneNumberChanged,
                phoneNumberCountry: controller.phoneNumberCountry,
              ),
              SizedBox(
                height: 15.h,
              ),
              TextFormField(
                key: const Key('Sign_up_name_field'),
                controller: controller.userNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(25),
                ],
                decoration: const InputDecoration(
                  hintText: 'User Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: controller.userNameValidator,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        GradientButton(
          isButtonDisable: controller.isButtonDisable,
          isWaitingForResponse: controller.isWaitingResponse,
          text: 'Sign up',
          onPressed: controller.signUp,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?  ',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: 12.sp,
                    ),
              ),
              GestureDetector(
                onTap: controller.goToLogIn,
                child: Text(
                  'Sign in',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12.sp,
                      ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    required this.textController,
    required this.onPhoneNumberChanged,
    required this.phoneNumberCountry,
    this.textInputAction = TextInputAction.done,
  });

  final TextEditingController textController;
  final Rx<Country> phoneNumberCountry;
  final TextInputAction textInputAction;

  static final phoneNumberFormatter = MaskTextInputFormatter(
    mask: '###-###-#####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final void Function(String phoneNumber) onPhoneNumberChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onChanged: (_) => onPhoneNumberChanged(phoneNumber),
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
        phoneNumberFormatter,
      ],
      decoration: InputDecoration(
        hintText: 'Phone Number',

        /// country (flag,code) & down Arrow
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 10.sp,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5.r),
                onTap: onPhoneFieldTapped,
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_drop_down,
                    ),
                    Obx(
                      () => Text(
                        phoneNumberCountry.value.flagEmoji,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () => Text(
                '  +${phoneNumberCountry.value.phoneCode}',
              ),
            ),
            SizedBox(
              width: 5.sp,
            ),
          ],
        ),
      ),
      validator: phoneNumberFieldValidator,
    );
  }

  String get phoneNumber {
    /// country international code + (unformatted) phone number from the text field
    return '${phoneNumberCountry.value.phoneCode}${phoneNumberFormatter.getUnmaskedText()}';
  }

  void onPhoneFieldTapped() {
    showCountryPicker(
      context: Get.context!,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 500.h,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      showPhoneCode: true,
      onSelect: (Country country) {
        onPhoneNumberChanged(phoneNumber);
        phoneNumberCountry.value = country;
      },
    );
  }

  String? phoneNumberFieldValidator(String? value) {
    if (value.isBlank!) {
      return 'required';
    }

    if (!value!.isPhoneNumber) {
      return 'Invalid phone number';
    }

    return null;
  }
}
