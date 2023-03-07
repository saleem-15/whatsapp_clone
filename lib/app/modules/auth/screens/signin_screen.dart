import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_button.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';

import 'package:whatsapp_clone/utils/constants/assests.dart';

import '../controllers/signin_controller.dart';
import '../views/sign_up_form.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key})
      : controller = Get.put(SigninController()),
        super(key: key);

  final SigninController controller;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Image.asset(
                    Assets.illustraion,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      'Sign in to your account',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: 20.sp,
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
                      height: 10.sp,
                    ),
                    Form(
                      key: controller.formKey,
                      child: PhoneNumberField(
                        key: const Key('Sign_in_phone_field'),
                        textController: controller.phoneNumberFieldController,
                        onPhoneNumberChanged: controller.onPhoneNumberChanged,
                        phoneNumberCountry: controller.phoneNumberCountry,
                      ),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    GradientButton(
                      isButtonDisable: controller.isButtonDisable,
                      isWaitingForResponse: controller.isWaitingResponse,
                      text: 'Sign in',
                      onPressed: controller.logIn,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?  ',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 12.sp,
                                ),
                          ),
                          GestureDetector(
                            onTap: controller.goToSignup,
                            child: Text(
                              'Sign up',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   RxBool isShowPassword = false.obs;

  //   /// vertical space between feilds && vertical space last feild and the button
  //   final verticalSpace = 15.h;

  //   /// padding for the form
  //   final horizontalPadding = 20.w;
  //   return Scaffold(
  //     appBar: AppBar(
  //       iconTheme: Theme.of(context).iconTheme,
  //     ),
  //     bottomNavigationBar: SizedBox(
  //       width: MediaQuery.of(context).size.width,
  //       height: 50.sp,
  //       child: Column(
  //         children: [
  //           const Divider(),
  //           Expanded(
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   'Don\'t have an account?  ',
  //                   style:
  //                       Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).hintColor),
  //                 ),
  //                 GestureDetector(
  //                   onTap: controller.goToSignup,
  //                   child: Text(
  //                     'Sign up',
  //                     style: Theme.of(context)
  //                         .textTheme
  //                         .bodyText1!
  //                         .copyWith(color: LightThemeColors.authButtonColor.withOpacity(.6)),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     body: Center(
  //       child: SingleChildScrollView(
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
  //           child: Column(
  //             children: [
  //               Image.asset(
  //                 'assets/icons/instagram-word-logo-removebg.png',
  //                 width: 150.sp,
  //               ),
  //               SizedBox(
  //                 height: 20.sp,
  //               ),
  //               Form(
  //                 key: controller.formKey,
  //                 // the textField is wrapped in (theme) so when the textField has Focus the icon color
  //                 //(in the textField) change to my specific color
  //                 child: Column(
  //                   children: [
  //                     TextFormField(
  //                       controller: controller.firstFieledController,
  //                       validator: controller.emailFieldValidator,
  //                       textInputAction: TextInputAction.next, // Moves focus to next field
  //                       decoration: const InputDecoration(
  //                         hintText: 'Phone number, email address or username',
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: verticalSpace,
  //                     ),
  //                     Obx(
  //                       () => TextFormField(
  //                         controller: controller.passwordController,
  //                         validator: controller.passwordFieldValidator,
  //                         obscureText: isShowPassword.isTrue,
  //                         decoration: InputDecoration(
  //                           hintText: 'Password',
  //                           suffixIcon: IconButton(
  //                             splashRadius: 5,
  //                             onPressed: () => isShowPassword.toggle(),
  //                             icon: isShowPassword.isTrue
  //                                 ? FaIcon(
  //                                     FontAwesomeIcons.eye,
  //                                     color: LightThemeColors.authButtonColor,
  //                                     size: 15.sp,
  //                                   )
  //                                 : FaIcon(
  //                                     FontAwesomeIcons.eyeSlash,
  //                                     color: Theme.of(context).disabledColor,
  //                                     size: 15.sp,
  //                                   ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: verticalSpace,
  //               ),
  //               Obx(
  //                 () => ElevatedButton(
  //                   onPressed: controller.isWaitingResponse.isTrue || controller.isButtonDisable.isTrue
  //                       ? null
  //                       : controller.logIn,
  //                   style: MyStyles.getAuthButtonStyle(),
  //                   child: controller.isWaitingResponse.isTrue
  //                       ? const LoadingWidget.button()
  //                       : const Text('Log in'),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10.sp,
  //               ),
  //               GestureDetector(
  //                 onTap: controller.forgotPassword,
  //                 child: RichText(
  //                   text: TextSpan(
  //                     children: [
  //                       TextSpan(
  //                         text: 'Forgotten your login details? ',
  //                         style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13.sp),
  //                       ),
  //                       TextSpan(
  //                         text: 'Get help with logging in.',
  //                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
  //                               fontSize: 13.sp,
  //                               color: Colors.indigo.shade800,
  //                             ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 50.h,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
