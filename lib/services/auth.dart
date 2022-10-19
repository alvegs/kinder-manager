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
    return userCredential.user;
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

  String? getUserId() {
    return _firebaseAuth.currentUser?.email;
  }
}
