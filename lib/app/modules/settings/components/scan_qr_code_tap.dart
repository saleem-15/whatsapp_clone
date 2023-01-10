// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/utils/constants/assest_path.dart';

import '../controllers/qr_screen_controller.dart';

final SCAN_BORDER_WIDTH = 250.w;

class ScanQRCodeTap extends StatelessWidget {
  const ScanQRCodeTap({
    super.key,
    required this.controller,
  });

  final QRScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Scanning widget
        MobileScanner(
          allowDuplicates: false,
          onDetect: controller.onBarcodeDetected,
        ),

        /// Blur effect widget
        /// the  [ClipRect] widget cuts any Blur that may affect other widgets
        ClipRect(
          child: ClipPath(
            clipper: _MyRoundedRectangleClipper(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(.0)),
              ),
            ),
          ),
        ),

        /// Barcode scanning border
        Center(
          child: Image.asset(
            Assets.QR_SCANNER_BORDER,
            width: SCAN_BORDER_WIDTH,
            color: MyColors.Green,
          ),
        ),
      ],
    );
  }
}

class _MyRoundedRectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    ///Rectangle based on the center of the screen (like the scanner border)
    ///and with the same width & height of the scanner border
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      height: SCAN_BORDER_WIDTH,
      width: SCAN_BORDER_WIDTH,
    );

    ///add some corners to the previous rectangle
    final p1 = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          rect,
          const Radius.circular(30),
        ),
      );

    /// create a rectangle that as large as possiple (takes the whole screen)
    final p2 = Path()..addRect(Rect.largest);

    /// now clip the rounded rectangle [p1] from [p2]
    final path = Path.combine(PathOperation.difference, p2, p1);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
