// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String phoneNumber;
  String? image;

  User({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.image,
  });

  factory User.fromDoc(QueryDocumentSnapshot doc) {
    return User(
      uid: doc.id,
      name: doc['name'] as String,
      phoneNumber: doc['phoneNumber'] as String,
      image: doc['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': image,
    };
  }
}
