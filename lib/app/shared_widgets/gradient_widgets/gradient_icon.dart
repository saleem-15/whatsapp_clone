// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:whatsapp_clone/config/theme/colors.dart';

class GradientIcon extends StatelessWidget {
  const GradientIcon({
    Key? key,

    /// the size of the background
    this.icon,
    this.assetIconPath,
    this.iconSize,
    this.gradientType,
    this.boxShape,
    this.backgroundSize,
    this.hasBackground = false,
    this.backgroundColor,
  })  : assert(icon == null || assetIconPath == null),
        super(key: key);

  final IconData? icon;
  final String? assetIconPath;
  final double? iconSize;
  final GradientType? gradientType;
  final BoxShape? boxShape;

  ///the size of the widget (the background of the icon (if exist) )
  final double? backgroundSize;
  final bool hasBackground;
  final Color? backgroundColor;

  static final iconBackgroundBorderRadius = BorderRadius.circular(10.r);
  @override
  Widget build(BuildContext context) {
    /// the icon size that is used
    double usedIconSize = iconSize ?? Theme.of(context).iconTheme.size ?? 24;

    Widget iconWidget;
    if (icon != null) {
      iconWidget = Icon(
        icon!,
        size: usedIconSize,
        color: Colors.white,
      );
    } else {
      iconWidget = ImageIcon(AssetImage(assetIconPath!));
    }

    final gradientIcon = ShaderMask(
      child: SizedBox(
        width: usedIconSize * 1.2,
        height: usedIconSize * 1.2,
        child: iconWidget,
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, usedIconSize, usedIconSize);
        return (gradientType == null ? MyColors.greenGradient : getGradient(gradientType!))
            .createShader(rect);
      },
    );

    if (!hasBackground) {
      return gradientIcon;
    }

    return Container(
      width: backgroundSize ?? usedIconSize + 4.sp,
      height: backgroundSize ?? usedIconSize + 4.sp,
      decoration: BoxDecoration(
        shape: boxShape ?? BoxShape.rectangle,
        color: backgroundColor ?? MyColors.LightGreen,
        borderRadius: boxShape != null ? null : iconBackgroundBorderRadius,
      ),
      child: gradientIcon,
    );
  }
}
