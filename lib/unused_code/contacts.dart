// See installation notes below regarding AndroidManifest.xml and Info.plist
import 'dart:developer';

import 'package:flutter_contacts/flutter_contacts.dart';

class MyContacts {
  MyContacts._();

  /// returnes all the phone numbers stored in the device,
  /// if a person has multiple phone numbers `it takes all his phone numbers`
  ///
  /// if the permission to contacts is not granted it throws an exception
  static Future<List<String>> getMyContacts() async {
    List<String> phoneNumbers = [];

    /// Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
      log('*** Num of contacts:${contacts.length}  ***');

      ///take only the phone numbers for each contact
      for (Contact contact in contacts) {
        final contactPhoneNumbers = contact.phones.map((e) => e.number);
        phoneNumbers.addAll(contactPhoneNumbers);
      }
      log('*** Num of phone Numbers:${phoneNumbers.length}  ***');
      return phoneNumbers;
    }
    throw 'Permission to contacts is not granted';
  }

  static Future<void> addNewContact(String phoneNumber, String firstName, [String lastName = '']) async {
    // Insert new contact
    final newContact = Contact()
      ..name.first = firstName
      ..name.last = lastName
      ..phones = [Phone(phoneNumber)];
    await newContact.insert();
  }

  static void listenToContacts() {
    // Listen to contact database changes
    FlutterContacts.addListener(() => log('Contact DB changed'));
  }
}
