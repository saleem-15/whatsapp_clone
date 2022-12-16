import 'dart:convert';

import '../../utils/utils.dart';
import 'message.dart';

class Chat {
  /// if the chat is for a user then only one element in the list .
  /// if its for a group then there is multiple elements
  List<String> usersIds;

  // (user name) Or (group name)
  String name;

  String image;

  String chatPath;

  final bool isGroupChat;

  late List<Message> messages = [];

  Chat({
    required this.usersIds,
    required this.name,
    required this.image,
    required this.chatPath,
    this.isGroupChat = false,
  });

  Chat.group({
    required this.usersIds,
    required this.name,
    required this.image,
    required this.chatPath,
    this.isGroupChat = true,
  });

  Map<String, dynamic> toMap() {
    return isGroupChat
        ? <String, dynamic>{
            'name': name,
            'image': image,
            'chatPath': chatPath,
            'usersIds': usersIds,
          }
        : <String, dynamic>{
            'name': name,
            'image': image,
            'chatPath': chatPath,
            'userId': usersIds[0],
          };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    final bool isGroup = Utils.getCollectionId(map['chatPath']) == 'Group_chats';

    return isGroup
        ? Chat.group(
            name: map['name'] as String,
            image: map['image'] as String,
            chatPath: map['chatPath'] as String,
            usersIds: map['usersIds'] as List<String>,
          )
        : Chat(
            name: map['name'] as String,
            image: map['image'] as String,
            chatPath: map['chatPath'] as String,
            usersIds: [map['userId'] as String],
          );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(userId: $usersIds, name: $name, image: $image, chatPath: $chatPath, isGroupChat: $isGroupChat)';
  }
}
