import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/app/api/messaging_api.dart';
import 'package:whatsapp_clone/app/api/user_api.dart';
import 'package:whatsapp_clone/app/models/chats/group_chat.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/utils/exceptions/chat_exceptions.dart';

import '../models/chats/chat_interface.dart';
import 'api.dart';

/// returns null if the user does not exist
Future<User?> checkMyContactsAreExists(List<String> phoneNumbers) async {
  while (phoneNumbers.isNotEmpty) {
    ///sned query of 10 phone numbers at each time
    /// (becuase firebase can't take more than 10)
    await getUsersThatHaveOneOfThePhoneNumbers(phoneNumbers.sublist(0, 10));

    ///remove the 10 phone numbers that are used in the query
    phoneNumbers.removeRange(0, 10);
  }

  return null;
}

///checks if the user is in my contacts
bool checkIsAContact(String userUid) {
  ///a map (Map<userId,privateChatId>) that contains all my contacts
  ///and the chat id for each contact
  final myContactsIds = UserApi.myDocument.getMap<String, String>('contacts');

  return myContactsIds.keys.toList().contains(userUid);
}

/// it creates a chat between me and the provided user
///
/// throws [ChatException] if the chat already exists
Future<void> createPrivateChat(String userId) async {
  /// check if the user is already in my contacts
  final isAlreadyAContact = checkIsAContact(userId);

  if (isAlreadyAContact) {
    throw ChatException.chatAlreadyExists();
  }

  // create a batch, used to perform multiple writes as a single atomic operation.
  final batch = db.batch();

  /// (1) Create the chat document that we (me,other user) will communicate through
  DocumentReference chatDoc = chatsCollection.doc();
  batch.set(
    chatDoc,
    {
      Chat.CHAT_TYPE_KEY: 'privateChat',
      Chat.CREATED_AT_KEY: FieldValue.serverTimestamp(),
      Chat.CHAT_MEMBERS_KEY: [
        myUid,
        userId,
      ],
    },
  );

  ///(2) Add `me` as a contact `for the user` & Add the chat document id.
  DocumentReference otherUserDoc = usersCollection.doc(userId);
  batch.update(
    otherUserDoc,
    {
      'contacts.$myUid': chatDoc.id,
    },
  );

  ///(3) Add the `user` as a contact for `me` & Add chat document id.
  batch.update(
    myUserDocument,
    {
      'contacts.$userId': chatDoc.id,
    },
  );

  await batch.commit();
}

///fetches user documents from firebase,and returns List of users docs.
///
/// returns null if there is not any registered user in the system (that owns a phone number)
/// (users that have a phone number that exists in the list of phone numbers that was provided)
Future<List<User>?> getUsersThatHaveOneOfThePhoneNumbers(List<String> phoneNumbers) async {
  final List<User> users = [];

  final queryResult = await usersCollection
      .where(
        'phoneNumber',
        whereIn: phoneNumbers,
      )
      .get();
  final userDocs = queryResult.docs;

  if (userDocs.isEmpty) {
    return null;
  }

  ///convert the user document into [User] object and add it to [users] list
  for (final user in userDocs) {
    users.add(User.fromDoc(user));
  }
  return users;
}

/// Creates a group document, and updates all its users documetns
/// `(it adds group id to every user 'groups' array)`
///
/// [groupMembersIds] is an array of all group members (even me)
Future<void> createGroupChat({
  required String groupName,
  String? bio,
  required List<String> groupMembersIds,
  File? groupImage,
}) async {
  // used to perform multiple writes as a single atomic operation.
  final batch = db.batch();

  ///(1) Create the chat document that we will communicate through
  final groupDoc = chatsCollection.doc();

  ///(2) if there is an image for the group => upload it and get the download url
  String? groupImageUrl;

  if (groupImage != null) {
    final imageId = MessagingApi.genereteFileId(myUid, groupImage.path);
    groupImageUrl = await MessagingApi.uploadFileToFirestorage(
      chatId: groupDoc.id,
      file: groupImage,
      fileName: imageId,
    );
  }

  /// (3) Set the attributes of the group document.
  batch.set(
    groupDoc,
    {
      GroupChat.GROUP_NAME_KEY: groupName,
      Chat.CHAT_TYPE_KEY: 'group',
      'imageUrl': groupImageUrl,
      Chat.CREATED_AT_KEY: FieldValue.serverTimestamp(),
      Chat.CHAT_MEMBERS_KEY: groupMembersIds,
      'bio': bio,
    },
  );

  /// (4) Update the `groups array` for all the members of the group (even me)
  /// (Add this group id  to `groups array`)
  for (String userId in groupMembersIds) {
    final userDoc = usersCollection.doc(userId);
    batch.update(
      userDoc,
      {
        'groups': FieldValue.arrayUnion([groupDoc.id]),
      },
    );
  }

  await batch.commit();
}
