import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //get instance of fireabse auth
  final FirebaseAuth _fireabseAuth = FirebaseAuth.instance;

  //get current user
  User? getCurrentUser() {
    return _fireabseAuth.currentUser;
  }

  //Sign In
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      //sign user in
      UserCredential userCredential =
          await _fireabseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    }on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Sign Up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      //sign user in
      UserCredential userCredential =
          await _fireabseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    }on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Sign Out
  Future<void> signOut() async {
    return await _fireabseAuth.signOut();
  }

}
