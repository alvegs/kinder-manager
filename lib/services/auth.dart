import 'package:firebase_auth/firebase_auth.dart';

/// Controls Firebase authorization in the project.
class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Creates a new user with given email and password.
  Future<User?> createUserWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final newUser = userCredential.user;
    if (newUser != null) {
      if (!newUser.emailVerified) {
        await newUser.sendEmailVerification();
      }
    }
    await newUser?.reload();
    return newUser;
  }

  /// Signs in the user with given credentials.
  Future<User?> signInWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(
        email: email,
        password: password,
      ),
    );
    return userCredential.user;
  }

  /// Signs out the user.
  Future<User?> signOut() async {
    await _firebaseAuth.signOut();
    return _firebaseAuth.currentUser;
  }

  /// User state will be notified when it changes.
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  /// Returns the current user.
  Future<User?> currentUser() async {
    return _firebaseAuth.currentUser;
  }

  /// Returns whether the user email is verified.
  Future<bool?> isEmailVerified(String email, String password) async {
    return await _firebaseAuth
        .signInWithCredential(
          EmailAuthProvider.credential(
            email: email,
            password: password,
          ),
        )
        .then((value) => value.user?.emailVerified);
  }
}
