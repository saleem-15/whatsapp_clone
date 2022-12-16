import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ChatBacground {
  color,
  image,
}

class MessageBubbleSettings {
  static final RxInt _fontSize = 1.obs;
  static final RxString _chatBackgroundImage = '1'.obs;
  static final _backgroundType = ChatBacground.color.obs;
  static final Rx<Color> _chatBackgroundColor = const Color(0xff112233).obs;

  static List<String> backgroundImages = [
    'assets/chat_background_light.png',
    'assets/chat_background_black.jpg',
    'assets/chat_background_dark_blue.png',
  ];

  static setFontSize(int newValue) async {
    _fontSize.value = newValue;
  }

  static get fontSize {
    return _fontSize;
  }

  static Rx<ChatBacground> get backgroundType => _backgroundType;

  static setchatBackgroundType(ChatBacground type) async {
    _backgroundType.value = type;
  }

  static RxString get chatBackgroundImage => _chatBackgroundImage;

  static setchatBackgroundImage(String imagePath) async {
    chatBackgroundImage.value = imagePath;
  }

  static setchatBackgroundColor(Color color) async {
    _chatBackgroundColor.value = color;
  }

  static get chatBackgroundColor => _chatBackgroundColor;

  static Color myMessageColor = Colors.blue;
  // Color(0xff2176FF);
  //Colors.green;
  static Color othersMessageColor = Colors.white;
}
