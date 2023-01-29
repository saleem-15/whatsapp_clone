import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/app/models/chats/chat_interface.dart';
import 'package:whatsapp_clone/app/models/chats/group_chat.dart';
import 'package:whatsapp_clone/app/models/chats/private_chat.dart';
import 'package:whatsapp_clone/utils/extensions/my_extensions.dart';

import 'api.dart';

class ChatsApi {
  ChatsApi._();

  /// this method returns all my chats (private and group chats)
  ///
  /// How it works:
  /// 1) it uses [_getMyChatsId] to fetch all my chats Ids.
  /// 2) runs a query that fetches all my chats docuemnts.
  /// 3) converts the group chat docuemtns into [GroupChat] objects.
  /// 4) give the [_getAllPrivateChats] method a
  /// list of private chat docs, and it returns [PrivateChat] objects.
  ///
  /// WHY step ((4)) because privateChat document has only 3 fields in it
  /// `(createdAt, members array, chatType)`
  /// so i need to also fetch the other user document,
  /// the method [_getAllPrivateChats] takes care of that & it returns a [PrivateChat] object
  static Future<List<Chat>> getAllMyChats() async {
    /// (1) ids of my chats (private & group chats)
    List<String> chatIds = await _getMyChatsId();

    /// if there is not any chats => return empty list
    if (chatIds.isEmpty) {
      return [];
    }

    List<QueryDocumentSnapshot> privateChatsDocs = [];
    List<Chat> allMyChats = [];

    /// All my chats (private & group)

    /// (2) query to retrive all my chat Documents (private & Groups chats)
    final queryResult = await getChatDocs(chatIds);

    for (final chatDoc in queryResult.docs) {
      /// (3) convert my group chat doc into a [GroupChat] object
      if (chatDoc['chatType'] == 'group') {
        allMyChats.add(GroupChat.fromChatDoc(chatDoc));

        /// if it was a private chat
      } else {
        /// I collect all my private chat documents in a list
        /// so i make a 1 request to firestore to get all of them
        /// instead of making a separate request for each private chat
        privateChatsDocs.add(chatDoc);
      }
    }

    if (privateChatsDocs.isNotEmpty) {
      ///(4)
      final myPrivateChats = await _getAllPrivateChats(privateChatsDocs);
      allMyChats.addAll(myPrivateChats);
    }

    return allMyChats;
  }

  /// `input`: list of group chat ids\
  /// `output`:list of group chat docs
  static Future<List<GroupChat>> getGroupChatsByIds({required List<String> groupChatIds}) async {
    if (groupChatIds.isEmpty) {
      return [];
    }

    /// query to retrive all my Group chat Documents
    final queryResult = await getChatDocs(groupChatIds);

    /// transform the group chat doc into a [GroupChat] object
    return queryResult.docs
        .map(
          (groupChatdoc) => GroupChat.fromChatDoc(groupChatdoc),
        )
        .toList();
  }

  /// `input`: list of private chat ids\
  /// `output`:list of private chat docs
  static Future<List<PrivateChat>> getPrivateChatsByIds({required List<String> privateChatIds}) async {
    if (privateChatIds.isEmpty) {
      return [];
    }

    /// query to retrive all my Group chat Documents
    final queryResult = await getChatDocs(privateChatIds);

    /// transform the group chat doc into a [GroupChat] object
    return await _getAllPrivateChats(queryResult.docs);
  }

  /// makes a query to get the chat docs (works for both private & group chats)
  static Future<QuerySnapshot> getChatDocs(List<String> chatDocsIds) async {
    return await chatsCollection
        .where(
          FieldPath.documentId,
          whereIn: chatDocsIds,
        )
        .get();
  }

  /// retrives the info of all the private chats from Firestore
  /// and returns them as privateChat objects
  static Future<List<PrivateChat>> _getAllPrivateChats(List<QueryDocumentSnapshot> privateChatsDocs) async {
    /// key: otherUserId
    /// value: priavateChatDoc
    Map<String, QueryDocumentSnapshot> otherUsers = _getOtherUsersMap(privateChatsDocs);

    /// request to get all the users info
    final queryResult =
        await usersCollection.where(FieldPath.documentId, whereIn: otherUsers.keys.toList()).get();

    return queryResult.docs
        .map(
          (userDoc) => PrivateChat.fromChatAndUserDocs(
            userDoc: userDoc,
            chatDoc: otherUsers[userDoc.id]!,
          ),
        )
        .toList();
  }

  /// it retruns a map where:\
  /// `key => otherUser ID`\
  /// `value => priavateChatDoc`
  static Map<String, QueryDocumentSnapshot> _getOtherUsersMap(List<QueryDocumentSnapshot> privateChatDocs) {
    Map<String, QueryDocumentSnapshot> otherUsers = {};

    for (final privateChat in privateChatDocs) {
      final chatMembers = privateChat['members'];

      String otherUser = chatMembers[0] == myUid ? chatMembers[1] : chatMembers[0];

      otherUsers.addAll({otherUser: privateChat});
    }
    return otherUsers;
  }

  /// returnes the ids of users chats (private & group chats)
  static Future<List<String>> _getMyChatsId() async {
    ///this is my user document
    final myDoc = await usersCollection.doc(myUid).get();

    /// make sure that my document exists
    assert(myDoc.exists);

    final privateChats = myDoc.getStringList('chats');
    final myGroups = myDoc.getStringList('groups');

    return [...privateChats, ...myGroups];
  }
}
