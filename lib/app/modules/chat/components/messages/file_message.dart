import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:whatsapp_clone/app/models/messages/file_message.dart';
import 'package:whatsapp_clone/app/modules/chat/controllers/chat_screen_controller.dart';
import 'package:whatsapp_clone/app/shared_widgets/gradient_widgets/gradient_icon.dart';
import 'package:whatsapp_clone/storage/files_manager.dart';
import 'package:whatsapp_clone/utils/helpers/message_bubble_settings.dart';
import 'package:whatsapp_clone/utils/helpers/utils.dart';

class FileMessageBubble extends GetView<ChatScreenController> {
  const FileMessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final FileMessage message;

  final double borderRadius = 15;

  @override
  Widget build(BuildContext context) {
    final messageColor =
        message.isMyMessage ? MessageBubbleSettings.myMessageColor : MessageBubbleSettings.othersMessageColor;

    log('file name is: ${message.downloadUrl.split('/').last}');

    /// the message takes a a row of the screen,
    /// and its aligned according if its my message or not
    return GestureDetector(
      onTap: () => controller.onFilePressed(message),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(10),
        margin: MessageBubbleSettings.messageMargin(
          isMyMessage: message.isMyMessage,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: messageColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          ///sender name at the top
          /// the rest of the message at bottom
          children: [
            /// Sender Name (shown if its not my message)
            if (!message.isMyMessage)
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 8, top: 3),
                child: Text(
                  message.senderName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            /// file name && file size && time sent
            SizedBox(
              width: double.infinity,
              height: 50.sp,
              child: Row(
                children: [
                  /// file icon
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white70,
                    ),
                    child: GradientIcon(
                      icon: FontAwesomeIcons.solidFileLines,
                      backgroundSize: 25.sp,
                    ),
                  ),

                  ///file (name & Size & Type)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// File Name
                          Text(
                            message.fileName,
                            style: MessageBubbleSettings.messageTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),

                          /// File Size & Type
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${message.formattedSize}  ${message.fileType.toUpperCase()}',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 12.sp,
                                      ),
                                ),
                                Expanded(
                                  child: Obx(
                                    () {
                                      /// if download is completed
                                      if (message.downloadProgress.value == 1) {
                                        Logger().i('Downloding is completed =>$message');
                                        return const SizedBox.shrink();
                                      }
                                      return DownloadProgress(message: message);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// time sent
                  Align(
                    alignment: const Alignment(0, 1),
                    child: Text(
                      Utils.formatDate(message.timeSent),
                      style: MessageBubbleSettings.timeSentTextStyle,
                    ),
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),

                  // Align(
                  //   alignment: const Alignment(0, 1),
                  //   child: Icon(
                  //     message.isSeen ?
                  //     // FontAwesomeIcons.clock,
                  //     // Icons.done_all_rounded,
                  //     Icons.done,
                  //     size: 16.sp,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DownloadProgress extends StatelessWidget {
  DownloadProgress({
    super.key,
    required this.message,
  });

  final FileMessage message;
  // final RxDouble downloadProgress = 0.0.obs;
  final RxBool isDownloading = false.obs;

  Future<void> onTap() async {
    isDownloading.value = true;
    final chatStoragePath = await FileManager.getChatStoragePath(message.chatId);

    String fileName = FileManager.generateFileMessageFileName(
      message.timeSent,
      originalFileName: message.fileName,
    );
    // .generateFileName(message.type, message.chatId, message.timeSent);
    String filePath = '$chatStoragePath/$fileName';

    FileManager.downloadFile(
      downloadUrl: message.downloadUrl,
      filePath: filePath,
      onProgressChanges: (received, total) {
        final progress = received / total;
        message.downloadProgress.value = received / total;

        log('downloading progress: $progress');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isDownloading.value
          ? CircularProgressIndicator(
              value: message.downloadProgress.value,
              color: Colors.red,
            )
          : Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_downward),
            ),
      //  Obx(
      //   () {
      //     return CircularProgressIndicator(
      //       value: downloadProgress.value,
      //       color: Colors.red,
      //     );
      //   },
      // ),
    );
  }
}

// class DownloadFileExample extends StatefulWidget {
//   @override
//   _DownloadFileExampleState createState() => _DownloadFileExampleState();
// }

// class _DownloadFileExampleState extends State<DownloadFileExample> {
//   final double _downloadProgress = 0.0;
//   final Dio _dio = Dio();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (_downloadProgress != 1.0) CircularProgressIndicator(value: _downloadProgress),
//             ElevatedButton(
//               onPressed: ,
//               child: const Text('Download File'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
