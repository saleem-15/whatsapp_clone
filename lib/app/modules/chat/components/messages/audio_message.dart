// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:whatsapp_clone/config/theme/colors.dart';
import 'package:whatsapp_clone/utils/helpers/message_bubble_settings.dart';

class AudioMessageBubble extends StatelessWidget {
  const AudioMessageBubble({
    Key? key,
    required this.isMyMessage,
    required this.audioPath,
    required this.timeSent,
  }) : super(key: key);

  final bool isMyMessage;
  final String audioPath;
  final String timeSent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: isMyMessage ? 8 : 0,
            left: isMyMessage ? 0 : 8,
            bottom: 5,
            top: 3,
          ),
          child: Stack(
            children: [
              VoiceMessage(
                meBgColor: MyColors.Green,
                // meFgColor: MyColors.LightBlack,

                // mePlayIconColor: MyColors.LightBlack,
                // contactFgColor: MyColors.red,
                // contactPlayIconColor: MyColors.red,

                audioSrc: audioPath,
                contactBgColor: isMyMessage
                    ? MessageBubbleSettings.myMessageColor
                    : MessageBubbleSettings.othersMessageColor,

                //  played: true, // To show played badge or not.
                me: isMyMessage, // Set message side.
                onPlay: () {}, // Do something when voice played.
              ),
              Positioned(
                bottom: 2,
                right: 5,
                child: Text(
                  timeSent,
                  style: MessageBubbleSettings.messageTextStyle.copyWith(
                    fontSize: 11.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
