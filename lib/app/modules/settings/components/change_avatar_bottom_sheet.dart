import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:whatsapp_clone/app/shared_widgets/gradient_icon.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';

class ChangeUserAvatarBottomSheet extends StatelessWidget {
  const ChangeUserAvatarBottomSheet({
    Key? key,
    required this.chooseUserImageFromGallery,
    required this.chooseUserImageFromCamera,
  }) : super(key: key);

  final Function() chooseUserImageFromGallery;
  final Function() chooseUserImageFromCamera;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200.h,
      padding: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.r),
          topRight: Radius.circular(35.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 7.h,
          ),

          /// handle shape (the grey line at the top)
          Container(
            width: 40.sp,
            height: 3.sp,
            decoration: BoxDecoration(
              color: const Color(0xffe0e0e0),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            'Change Avatar',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 20.sp,
          ),

          /// From Camera Card
          _buildOptionCard(
            text: 'Take Photo',
            icon: Icons.camera_alt_outlined,
            onPressed: chooseUserImageFromCamera,
          ),
          SizedBox(
            height: 20.sp,
          ),

          /// From Gallery Card
          _buildOptionCard(
            text: 'From Gallery',
            icon: Icons.image_search_rounded,
            onPressed: chooseUserImageFromGallery,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({required String text, required IconData icon, required Function() onPressed}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      height: 140.sp,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 100,
              spreadRadius: -50,
              color: MyColors.LightBlack,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientIcon(
                icon: icon,
                hasBackground: true,
                backgroundSize: 60.sp,
                iconSize: 30.sp,
                boxShape: BoxShape.circle,
              ),
              SizedBox(
                height: 10.sp,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
