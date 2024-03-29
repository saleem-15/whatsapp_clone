import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/models/messages/message.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/storage/database/daos/chats_dao.dart';
import 'package:whatsapp_clone/storage/database/daos/users_dao.dart';
import 'package:whatsapp_clone/storage/database/database.dart';

import '../models/message.dart';

class MessagesDao {
  MessagesDao._();

  //------------------------adding-------------------------------
  /// this method is faster than [addMsg]
  static Future<void> addMessage({
    required Chat chat,
    required User sender,
    required Message message,
  }) async {
    final msg = MessageDB.fromMessageInterface(message);
    msg.sender.value = sender;

    await isar.writeTxn(() async {
      /// save the message in the messages collection
      await isar.messages.put(msg);
      await msg.sender.save();

      /// link the message to its chat (the message is in a chat)
      chat.messages.add(msg);
      await chat.messages.save();
    });
  }

  /// inserts a new message, Consider using [addMessage] method (its faster)
  static Future<void> addMsg(Message message) async {
    // Logger().w('add message (DB)');
    User? sender = await UsersDao.getUserByMyID(message.senderId);
    // Logger().w('user fetched: $sender');
    final chat = (await ChatsDao.getChatByMyId(message.chatId))!;
    // Logger().w('chat fetched: $chat');

    return addMessage(chat: chat, sender: sender!, message: message);
  }

  ///pass the message with its updated file url\
  ///only used For updating the message download url\
  ///`WARNING: If it was used for any thing else unpredictable problems will arise`
  static void updateDownloadUrl(Message message, {bool silent = true}) {
    final msg = MessageDB.fromMessageInterface(message);

    isar.writeTxnSync(silent: silent, () {
      /// save the message in the messages collection
      isar.messages.putSync(msg);
    });
  }

  static Future<void> addMultipleMessages(Chat chat, List<Message> messages) async {
    final msgs = messages.map((e) => MessageDB.fromMessageInterface(e)).toList();

    await isar.writeTxn(() async {
      /// save the message in the messages collection
      await isar.messages.putAll(msgs);

      /// link the messages to its chat (the messages is in a chat)
      chat.messages.addAll(msgs);
      await chat.messages.save();
    });
  }
  //--------------------------updating-------------------------------

  // static Future<void> updateMessage(MessageInterface message) async {
  //   return addMessage(message);
  // }

  // static Future<void> updateMultipleMessages(List<MessageInterface> messages) async {
  //   return addMultipleMessages(messages);
  // }

  //--------------------------Delete-------------------------------
  /// Delete a single object by its [id].\
  /// Returns whether the object has been deleted.
  // static Future<bool> deleteMessage(MessageDB message) async {
  //   return await isar.writeTxn(() async {
  //     return await isar.messages.delete(message.id);
  //   });
  // }

  // static Future<void> deleteMessageById(int messageId) async {
  //   await isar.writeTxn(() async {
  //     return await isar.messages.delete(messageId);
  //   });
  // }

  // static Future<void> deleteMultipleMessagesById(List<MessageDB> messagesIds) async {
  //   await isar.writeTxn(() async {
  //     await isar.messages.deleteAll(
  //       messagesIds.map((e) => e.id).toList(),
  //     );
  //   });
  // }

  //--------------------------Get-------------------------------
  static Future<MessageDB?> getMessage(int id) async {
    return isar.messages.get(id);
  }

  static Future<List<MessageDB>> getAllChatMessages(String chatId) async {
    return isar.messages.filter().chatIdEqualTo(chatId).findAll();
  }

  static Future<List<int>> getAllChatMessagesIDs(String chatId) async {
    final messages = await getAllChatMessages(chatId);

    /// return only the ids
    return messages.map((e) => e.id).toList();
  }

  static Stream<List<Message>> getChatMessagesStream(Chat chat) {
    return chat.messages
        .filter()
        .sortByTimeSentDesc()
        .watch(fireImmediately: true)
        .map((List<MessageDB> messagesDB) {
      final List<Message> msgs = [];

      Logger().wtf(messagesDB.length);

      for (var message in messagesDB) {
        msgs.add(Message.fromDB(message));
      }

      return msgs;
    });
  }
}
