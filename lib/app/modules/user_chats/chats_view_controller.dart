import 'package:get/get.dart';
import 'package:whatsapp_clone/app/models/chat.dart';

class ChatsViewController extends GetxController {
  var myChatsList = <Rx<Chat>>[].obs;

  var myUser;

  void onChatTilePressed() {
    // Get.to(
    //   () => ChatScreen(chatPath: chatPath, image: image, name: name, userId: userId),
    //   transition: Transition.fadeIn,
    //   duration: const Duration(milliseconds: 400),
    //   curve: Curves.easeIn,
    // );
  }

  getUserbyId(String senderId) {
    return 'wtf';
  }
}
