// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Info'),
      ),
      body: Padding(
        padding: MyStyles.getHorizintalScreenPadding(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                Assets.illustraion,
                width: 280.w,
              ),
              SizedBox(
                height: 20.sp,
              ),
              Text(
                'WhatsUp Messanger',
                style: Theme.of(context).textTheme.headline2!,
              ),
              SizedBox(
                height: 20.sp,
              ),
              Text(
                'Version 4.37.38.6.79',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Text(
                '© 2012 - 2022 WhatsUp Inc.',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
