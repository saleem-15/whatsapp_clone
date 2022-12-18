import 'package:firebase_auth/firebase_auth.dart';

/// it returnes true if signup process is successful
Future<void> signInService(String phoneNumber) async {
  final result = await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);

  // result.
}
