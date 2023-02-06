import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/app/api/messaging_api.dart';
import 'package:whatsapp_clone/app/models/user.dart';
import 'package:whatsapp_clone/utils/exceptions/chat_exceptions.dart';

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

Future<bool> checkIsMeAndTheUserHavePrivateChat(String userUid) async {
  final result = await usersCollection.doc(myUid).get();

  List myContactsIds = result['myContacts'];

  return myContactsIds.contains(userUid);
}

/// it creates a chat between me and the provided user
///
/// throws [ChatException] if the chat already exists
Future<void> createPrivateChat(String userId) async {
  final doWeHaveAnExistingChat = await checkIsMeAndTheUserHavePrivateChat(userId);

  if (doWeHaveAnExistingChat) {
    ChatException.chatAlreadyExists();
    return;
  }
  // used to perform multiple writes as a single atomic operation.
  final batch = db.batch();

  /// Create the chat document that we will communicate through
  DocumentReference chatDoc = chatsCollection.doc();

  batch.set(
    chatDoc,
    {
      'chatType': 'privateChat',
      'createdAt': FieldValue.serverTimestamp(),
      'members': [
        myUid,
        userId,
      ],
    },
  );

  ///add our chat document id to his chats list
  DocumentReference otherUserDoc = usersCollection.doc(userId);
  batch.update(
    otherUserDoc,
    {
      'chats': FieldValue.arrayUnion([chatDoc.id]),
      'myContacts': FieldValue.arrayUnion([myUid])
    },
  );

  ///add the chat document id to my chats list
  DocumentReference myUserDoc = usersCollection.doc(myUid);
  batch.update(
    myUserDoc,
    {
      'chats': FieldValue.arrayUnion([chatDoc.id]),
      'myContacts': FieldValue.arrayUnion([userId])
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

/// creates a group document, and updates all its users documetns
/// (it adds group id to every user 'groups' array)
Future<void> createGroupChat(String groupName, List<String> selectedPeopleIds, File? groupImage) async {
  // FirebaseStorage.instance.ref().child(path)

  // used to perform multiple writes as a single atomic operation.
  final batch = db.batch();

  /// Create the chat document that we will communicate through
  DocumentReference groupDoc = chatsCollection.doc();

  String? groupImageUrl;

  if (groupImage != null) {
    final imageId = MessagingApi.genereteFileId(myUid, groupImage.path);
    groupImageUrl = await MessagingApi.uploadFileToFirestorage(
      chatId: groupDoc.id,
      file: groupImage,
      fileName: imageId,
    );
  }

  /// set some attributes of the group document
  batch.set(
    groupDoc,
    {
      'groupName': groupName,
      'chatType': 'group',
      'imageUrl': groupImageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'members': selectedPeopleIds,
      'bio': null,
    },
  );

  DocumentReference myDoc = usersCollection.doc(myUid);

  ///add the group document id to my groups list
  batch.update(
    myDoc,
    {
      'groups': FieldValue.arrayUnion([groupDoc.id]),
    },
  );

  for (String userId in selectedPeopleIds) {
    DocumentReference userDoc = usersCollection.doc(userId);

    ///add the group document id to the user groups list
    batch.update(
      userDoc,
      {
        'groups': FieldValue.arrayUnion([groupDoc.id]),
      },
    );
  }

  await batch.commit();
}
