import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final String myUid = auth.currentUser!.uid;
final FirebaseFirestore db = FirebaseFirestore.instance;

final Reference rootStorage = FirebaseStorage.instance.ref();
final CollectionReference usersCollection = db.collection('users');
final CollectionReference chatsCollection = db.collection('cahts');
