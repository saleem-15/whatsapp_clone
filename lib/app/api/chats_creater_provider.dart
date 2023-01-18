import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:whatsapp_clone/app/models/user.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;
final CollectionReference usersCollection = db.collection('users');
final CollectionReference chatsCollection = db.collection('cahts');
final String myUid = auth.currentUser!.uid;

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

/// it creates a chat between me and the provided user
Future<void> createChat(String userId) async {
  
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
      'chats': FieldValue.arrayUnion([chatDoc.id])
    },
  );


  ///add the chat document id to my chats list
  DocumentReference myUserDoc = usersCollection.doc(myUid);
  batch.update(
    myUserDoc,
    {
      'chats': FieldValue.arrayUnion([chatDoc.id])
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
