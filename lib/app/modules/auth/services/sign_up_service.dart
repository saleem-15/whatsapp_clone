// import 'package:firebase_auth/firebase_auth.dart';

// /// it returnes true if signup process is successful
// Future<void> signUpService(String phoneNumber) async {
//   FirebaseAuth auth = FirebaseAuth.instance;

//   await auth.verifyPhoneNumber(
//     phoneNumber: phoneNumber,
//     verificationCompleted: (PhoneAuthCredential credential) async {
//       // ANDROID ONLY!

//       // Sign the user in (or link) with the auto-generated credential
//       await auth.signInWithCredential(credential);
//     },
//     verificationFailed: (FirebaseAuthException e) {
//       if (e.code == 'invalid-phone-number') {
//         print('The provided phone number is not valid.');
//       }

//       // Handle other errors
//     },
//   );
// }
