import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chat_interface.dart';

class ChatScreenController extends GetxController {
  late final Chat chat;
  
  @override
  void onInit() {
    super.onInit();

    chat = Get.arguments;
  }

  void onAppBarPressed() {
    // Get.to(
    //   () => UserDetailsScreen(
    //     name: widget.name,
    //     image: widget.image,
    //     chatPath: widget.chatPath,
    //     isGroup: isGroupChat,
    //   ),
    // );
  }
}
