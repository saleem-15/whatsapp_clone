import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/config/theme/my_fonts.dart';

enum ChatBacground {
  color,
  image,
}

class MessageBubbleSettings {
  static final RxDouble _fontSize = MyFonts.body1TextSize.obs;
  static final RxString _chatBackgroundImage = '1'.obs;
  static final _backgroundType = ChatBacground.color.obs;
  static final Rx<Color> _chatBackgroundColor = const Color(0xff112233).obs;

  static BorderRadius borderRadius = BorderRadius.circular(15.r);

  static EdgeInsets messageMargin({required bool isMyMessage}) => EdgeInsets.only(
        right: isMyMessage ? 8 : 0,
        left: isMyMessage ? 0 : 8,
        bottom: 5,
        top: 3,
      );

  static TextStyle messageTextStyle = TextStyle(
    fontSize: _fontSize.value,
    color: MyColors.LightBlack,
  );
  static TextStyle timeSentTextStyle = TextStyle(
    fontSize: 11.sp,
    color: MyColors.LightBlack,
  );

  static List<String> backgroundImages = [
    'assets/chat_background_light.png',
    'assets/chat_background_black.jpg',
    'assets/chat_background_dark_blue.png',
  ];

  static setFontSize(double newValue) async {
    _fontSize.value = newValue;
  }

  static RxDouble get fontSize {
    return _fontSize;
  }

  static Rx<ChatBacground> get backgroundType => _backgroundType;

  static setChatBackgroundType(ChatBacground type) async {
    _backgroundType.value = type;
  }

  static RxString get chatBackgroundImage => _chatBackgroundImage;

  static setChatBackgroundImage(String imagePath) async {
    chatBackgroundImage.value = imagePath;
  }

  static setChatBackgroundColor(Color color) async {
    _chatBackgroundColor.value = color;
  }

  static get chatBackgroundColor => _chatBackgroundColor;

  static Color myMessageColor = MyColors.MyMessageColor;
  static Color othersMessageColor = MyColors.OtherMessageColor;
}
