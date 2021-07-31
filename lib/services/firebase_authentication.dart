import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message;
    }
  }

  Future registerAccount(
      {String email, String password, String displayName}) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      credential.user.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      throw e.message;
    }
  }

  User getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
