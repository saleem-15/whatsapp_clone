// See installation notes below regarding AndroidManifest.xml and Info.plist
import 'dart:developer';

import 'package:flutter_contacts/flutter_contacts.dart';

class MyContacts {
  Future<List<Contact>> getMyContacts() async {
    /// Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts = await FlutterContacts.getContacts();

      // Get all contacts (fully fetched)
      // contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      return contacts;
    }
    throw 'Permission to contacts is not granted';
  }

  Future<void> addNewContact(String phoneNumber, String firstName, [String lastName = '']) async {
    // Insert new contact
    final newContact = Contact()
      ..name.first = firstName
      ..name.last = lastName
      ..phones = [Phone(phoneNumber)];
    await newContact.insert();
  }

  listenToContacts() {
    // Listen to contact database changes
    FlutterContacts.addListener(() => log('Contact DB changed'));
  }
}
