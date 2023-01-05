// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    Key? key,
    required this.content,
    required this.cancelButtonText,
    required this.confirmButtonText,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  final Widget content;

  /// -------buttons-------
  final String cancelButtonText;
  final String confirmButtonText;

  final Function() onCancel;
  final Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisSize: MainAxisSize.min,
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

          ///Your Custom Widgets (text probably)
          content,

          SizedBox(
            height: 20.sp,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onCancel,
                  child: Text(cancelButtonText),
                ),
              ),
              SizedBox(
                width: 20.sp,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: onConfirm,
                  child: Text(confirmButtonText),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
