// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/shared_widgets/generic_button.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../controllers/chat_text_field_controller.dart';

class ChatTextField extends GetView<ChatTextFieldController> {
  const ChatTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///Text field
        Expanded(
          child: TextField(
            minLines: 1,
            maxLines: 5,
            controller: controller.textController,
            decoration: MyStyles.getChatTextFieldStyle().copyWith(
              hintText: 'Message',

              ///(Attach file & Camera) Icons (hidden When recording audio)
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///recording time (shown when recording)
                  if (controller.recorder.isRecording) controller.recordingTime(),

                  ///Attach file Icon
                  if (!controller.recorder.isRecording)
                    Material(
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      type: MaterialType.circle,
                      child: IconButton(
                        color: Theme.of(context).primaryColor,
                        icon: const FaIcon(FontAwesomeIcons.paperclip, size: 20),
                        onPressed: controller.showBottomSheet,
                      ),
                    ),

                  /// Camera Icon
                  if (!controller.recorder.isRecording)
                    Material(
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      type: MaterialType.circle,
                      child: IconButton(
                        color: Theme.of(context).primaryColor,
                        icon: const Icon(Icons.camera_alt_rounded),
                        onPressed: controller.onCameraIconPressed,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.sp,
        ),

        ///(Send --OR-- record audio) Icon
        Obx(
          () => controller.text.value.isBlank!
              ?

              /// Microphone Icon (shown When the textfield is empty)
              GradientGenericButton(
                  onPressed: controller.onMicIconPressed,
                  child: Icon(controller.recorder.isRecording ? Icons.stop : Icons.mic),
                )
              :

              /// Send Icon (shown When there is text in the textfield )
              GradientGenericButton(
                  onPressed: controller.sendMessage,
                  child: const Icon(Icons.send_rounded),
                ),
        ),
      ],
    );
  }
}
