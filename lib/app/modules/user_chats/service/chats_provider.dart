import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:whatsapp_clone/app/models/chat_interface.dart';
import 'package:whatsapp_clone/app/models/group.dart';
import 'package:whatsapp_clone/app/models/private_chat.dart';
import 'package:whatsapp_clone/app/models/user.dart';

class ChatsProvider {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final CollectionReference chatsCollection = db.collection('cahts');
  static final CollectionReference usersCollection = db.collection('users');

  static String myUid = FirebaseAuth.instance.currentUser!.uid;

  static Future<List<Chat>> getAllMyChats() async {
    List<Chat> myChats = [];
    List<QueryDocumentSnapshot> privateChats = [];

    List<String> chatIds = await _getMyChatsId();

    ///my chats Documents (private chats & Groups)
    final result = await chatsCollection.where(FieldPath.documentId, whereIn: chatIds).get();
    final chats = result.docs;

    for (final chatDoc in chats) {
      if (chatDoc['chatType'] == 'group') {
        myChats.add(GroupChat.fromChatDoc(chatDoc));
      } else {
        /// i collect all my private chat documents in a list
        /// so i make a 1 request to firestore to get all of them
        /// instead of making a separate request for each private chat
        privateChats.add(chatDoc);
      }
    }

    final myPrivateChats = await _getAllPrivateChats(privateChats);
    myChats.addAll(myPrivateChats);

    return myChats;
  }

  /// retrives the info of all the private chats from Firestore
  /// and creates privateChat objects
  static Future<List<PrivateChat>> _getAllPrivateChats(List<QueryDocumentSnapshot> chatDocs) async {
    List<PrivateChat> privateChatsList = [];

    /// Map<String,QueryDocumentSnapshot>  ==> QueryDocumentSnapshot: priavateChatDoc / String: otherUser ID
    Map<String, QueryDocumentSnapshot> otherUsers = _getOtherUsersMap(chatDocs);

    /// request to get all the users info
    final result = await usersCollection.where(FieldPath.documentId, whereIn: otherUsers.keys.toList()).get();

    final usersDocs = result.docs;

    for (int i = 0; i < usersDocs.length; i++) {
      final user = User.fromDoc(usersDocs[i]);

      final privateChat = PrivateChat(
        id: otherUsers[user.uid]!.id,
        user: user,
        usersIds: List.castFrom<dynamic, String>(otherUsers[user.uid]!['members']),
      );

      privateChatsList.add(privateChat);
    }

    return privateChatsList;
  }

  /// this is used to retrive private chats
  static Map<String, QueryDocumentSnapshot> _getOtherUsersMap(List<QueryDocumentSnapshot> chatDocs) {
    /// Map<String,QueryDocumentSnapshot>  ==> QueryDocumentSnapshot: priavateChatDoc / String: otherUser ID
    Map<String, QueryDocumentSnapshot> otherUsers = {};

    for (final privateChat in chatDocs) {
      final chatMembers = privateChat['members'];
      String otherUser;

      if (chatMembers[0] == myUid) {
        otherUser = chatMembers[1];
      } else {
        otherUser = chatMembers[0];
      }
      otherUsers.addAll({otherUser: privateChat});
    }
    return otherUsers;
  }

  static Future<List<String>> _getMyChatsId() async {
    final myDoc = await usersCollection.doc(myUid).get();

    final chats = (myDoc['chats'] as List)..addAll(myDoc['groups'] as List);

    return List.castFrom<dynamic, String>(chats);
  }
}