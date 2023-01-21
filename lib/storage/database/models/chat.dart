import 'package:isar/isar.dart';

import 'message.dart';

part 'chat.g.dart';

enum ChatType {
  privateChat,
  groupChat,
}

@Collection()
class Chat {
  Chat({
    required this.chatId,
    required this.name,
    required this.image,
    required this.usersIds,
    required this.messages,
    required this.isGroupChat,
  });
  Id id = Isar.autoIncrement;

  ///------ Shared Attributes for all types of chats -----------
  String chatId;
  String name;
  String? image;

  final List<String> usersIds;
  List<Message> messages;
  bool isGroupChat;

  ///------ Shared Attributes for all types of chats -----------

  ///******* Special Attributes for [PrivateChat]*******
  // final User user;

}