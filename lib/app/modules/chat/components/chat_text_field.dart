// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

import '../controllers/chat_text_field_controller.dart';

class ChatTextField extends GetView<ChatTextFieldController> {
  const ChatTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: 5,
      controller: controller.textController,
      decoration: MyStyles.getChatTextFieldStyle().copyWith(
        hintText: 'Message',
        suffixIcon: Obx(
          () => controller.text.trim().isEmpty
              ?

              ///(Attach file,record audio,camera) Icons (shown When the textfield is empty)

              Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.recorder.isRecording) controller.recordingTime(),
                    if (!controller.recorder.isRecording)

                      ///Attach file Icon
                      IconButton(
                        color: Theme.of(context).primaryColor,
                        icon: const FaIcon(FontAwesomeIcons.paperclip, size: 20),
                        onPressed: controller.showBottomSheet,
                      ),
                    IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(controller.recorder.isRecording ? Icons.stop : Icons.mic),
                      onPressed: controller.onMicIconPressed,
                    ),
                    if (!controller.recorder.isRecording)
                      IconButton(
                        color: Theme.of(context).primaryColor,
                        icon: const Icon(Icons.camera_alt_rounded),
                        onPressed: controller.onCameraIconPressed,
                      ),
                  ],
                )
              :

              /// Send Icon (shown When there is text in the textfield )
              IconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: controller.sendMessage,
                ),
        ),
      ),
      onChanged: controller.onTextChanged,
    );
  }
}

// Container(
//       width: MediaQuery.of(context).size.width,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       padding: const EdgeInsets.only(left: 20),
//       margin: const EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 10),
