// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// absstract class AuthBase {
//   User get currentUser;
//   Future<User> signInWithEmailAndPassword(String email, String password);
// }
//
//
// class Auth implements AuthBase {
//
//   final _firebaseAuth = FirebaseAuth.instance;
//
//   @override
//   Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();
//
//   @override
//   User get currentUser => _firebaseAuth.currentUser;
// }
//
// @override
// Future<User> signInWithEmailAndPassword(String email, String password) async {
//   final userCredential = await _firebaseAuth.signInWithCredential(
//     EmailAuthProvider.credential(email: email, password: password),
//   );
//   return userCredential.user;
//
//
//
//   @override
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
// }